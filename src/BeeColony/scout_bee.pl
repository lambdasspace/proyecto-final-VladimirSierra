:- [movements].
:- [compute].


/*
 * scout_bees_job(L, N, Pos_inicial, Z).
 * Predicado que es true si L es la lista de fuentes de comida, N la longitud del tablero y Pos_inicial la posicion de
 * inicio, Z es el resultado de modificar los elementos de L para extender soluciones y eliminar soluciones no optimas.
 */
scout_bees_job(L, N, Pos_inicial, Z):-
    path_with_max_fitness(L, N, Pos_inicial, (Limit,_) ),
    scout_job_aux(L, N, Pos_inicial, Limit, Z).


/*
 * scout_job_aux( L, N, Pos_inicial, Limit, Z).
 * Predicado que es true si L es la lista de todas las fuentes de comida, Limit el fitness value maximo en esa iteracion,
 * Z es el resultado de actualizar las fuentes en L en un tablero de NxN con posicion inicial Pos_inicial.
*/
scout_job_aux([], _ , _, _, []).
scout_job_aux([H|T], N, Pos_inicial, Limit, Z):-
    scout_job_aux(T, N, Pos_inicial, Limit, Z1),
    scout_update_sequence(H, N, Pos_inicial, Limit, H1),
    Z = [H1| Z1].


/*
 * scout_update_sequence( L, N, Pos_inicial, Limit, Z).
 * Predicado que es true si Z es el resultado de modificar la secuencia de patrones de moivmientos L con la estrategia de
 * abeja exploradora en un tablero de NxN y posicon inicial Pos_inicial, Limit es el fitness value maximo en ese punto.
*/
scout_update_sequence(Secuence, N, Pos_inicial, Limit, New_secuence):-
    extend_solution(Secuence, N, Pos_inicial,Limit, New_secuence),!.

%- Caso cuando no se puede extender mas la solucion y esta por debajo del limite.
scout_update_sequence(Secuence, N, Pos_inicial, Limit, New_secuence):-
    \+ extend_solution(Secuence, N, Pos_inicial,Limit,  _),
    random_init(N, New_secuence).


/*
 * extend_solution( L, N, Pos_inicial, Limit, Z).
 * Predicado que es true si L es una secuencia de patrones de movimientos, N la longitud del lado del tablero,
 * Pos_inicial la posicion de inicio, Limit es el umbral y Z es el resultado de modificar en L los movimientos no validos
 * para aumentar su fitness value.
*/
extend_solution(Sequence, N, Pos_inicial, Limit, New_sequence):-
    %- caso cuando el fitness value ya es el maximo.
    apply_sequence(Sequence, N,  (Pos_inicial, 0, [Pos_inicial]), (_, FV_final, _)),
    FV_final = Limit,
    Limit \= 0,
    %- obtenemos los movimentos no validos
    take_sublist(1,FV_final, Sequence, Z1),
    Rest is N * N -1 - FV_final,
    %- los reemplazamos
    random_list(Rest, Z2),
    append(Z1,Z2,New_sequence).

extend_solution(Sequence, N, Pos_inicial,Limit, New_sequence):-
    %- caso cuando se puede aumentar el fitness value actual
    apply_sequence(Sequence, N,  (Pos_inicial, 0, [Pos_inicial]), (Pos_final, FV_final, Visited_final)),
    (FV_final < Limit ; Limit == 0),
    %- Obtenemos el primer movimiento invalido
    nth0(FV_final, Secuense, Replace ),
    %- Buscamos un patro de movimiento distinto para aumentar el futness value
    random_patter(Replace, New_pattern),
    valid_move(Visited_final, Pos_final, New_pattern, N, _),
    %- Obtenemos la nueva secuencia reemplazando el viejo patron de movimento por el nuevo
    replace(FV_final, Secuense, New_pattern, New_sequence).


/*
 * random_patter(Dif, Z).
 * Predicado que es true si Z es un numero en el rango [1, 8] y es diferente a Dif.
*/
random_patter(Dif, Z):-
    random_permutation([1,2,3,4,5,6,7,8], Z1),
    member(Z2,Z1),
    Z2 \= Dif,
    Z = Z2.


/*
 * apply_sequence( L, N, (P1, F1, V1) , (Pf , Ff, Vf) ).
 * Predicado que es true si L es la lista de patrones de movimientos, N la longitud del tablero,
 * P1 es la posicion inicial, F1 es el fitness value asociado hasta ese punto, V1 es la lista de casillas visitadas
 * hasta ese momento, Pf es la posicion final luego de aplicar los movimientos validos, Ff el fitness value final y
 * Vf las casillas visitadas luego de aplicar los movimientos validos en L.
*/
apply_sequence([], _, R, R ).

apply_sequence( [H |T], N,  (Pos1, FV1, Visited1), (Pos_final, FV_final, Visited_final )):-
    %- para el caso en que el movimiento actual es valido
    valid_move(Visited1, Pos1, H, N, Pos_avance),
    %- el fitness value aumenta en uno
    New_fv is FV1 + 1,
    %- llamamos recursivamente con los valores actualizados y el resto de la secuencia
    apply_sequence( T, N,  (Pos_avance, New_fv, [Pos_avance | Visited1] ),  (Pos_final, FV_final, Visited_final) ).

apply_sequence([H|_], N,  (Pos1, FV1, Visited1), (Pos_final, FV_final, Visited_final )):-
    %- para el caso en que el movimiento actual no es valido
    \+ valid_move(Visited1, Pos1, H, N, _),
    %- el resultado final son los valores acumulados
    Pos_final = Pos1,
    FV_final is FV1,
    Visited_final = Visited1.



