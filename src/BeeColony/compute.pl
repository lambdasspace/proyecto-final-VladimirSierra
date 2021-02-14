:-[movements].

/*
 * random_init(N,Z).
 * Predicado que es true si N es un numero natural y Z es una lista de longitud (N^2)-1 con numeros random entre [1,8].
*/
random_init(N, Z):-
    Square is N * N,
    Longitud is Square -1,
    length(Z, Longitud),
    maplist( random(1,9), Z).


/*
 * random_init(K,Z).
 * Predicado que es true si K es un numero natural y Z es una lista de longitud K con numeros random entre [1,8].
*/
random_list(K, Z):-
    length(Z, K),
    maplist( random(1,9), Z).


/*
 * fitness_value(S, Pos_inicial, N, Z).
 * Predicado que es true si Z es el valor que toma la funcion fitness para la secuencia S tomando Pos_inicial como
 * posicion de inicio.
*/
fitness_value(S, Pos_inicial, N,  Z):-
    fitness_value_aux(S, [Pos_inicial], Pos_inicial, N, Z).

/*
 * fitness_value_aux(L, Visited, Pos_inicial, N, Z).
 * Predicado auxiliar que es true si L es la lista de patrones de movimientos, Visited es la lista de casillas visitadas
 * hasta ese momento, Pos inicial es la posicion de inicio, N es la longitud del lado del tablero y Z es el fitness value
 * asociado a L
*/
fitness_value_aux([], _, _, _, 0).

%- Caso recursivo, cuando el movmimiento es valido.
fitness_value_aux([H|T] , Visited,  PosInicial, N, Z):-
    valid_move( Visited , PosInicial, H, N,  PosFinal),
    fitness_value_aux( T, [PosFinal | Visited] , PosFinal,N, Z1),!,
    Z is Z1 + 1.

%- Caso recursivo, cuando el movimiento no es valido
fitness_value_aux([H|_] , Visited,  PosInicial, N,  Z):-
    \+ valid_move([PosInicial|Visited], PosInicial, H, N , _),
    Z is 0.


/*
 * take(N, L1, L2).
 * Predicado que es true si L2 es el resultado de tomar los primeros N elementos de L1.
*/
take(0, _, []) :- !.
take(N, [H|TA], [H|TB]) :-
    N > 0,
    N2 is N - 1,
    take(N2, TA, TB).


/*
 * drop(N, L1, L2).
 * Predicado que es true si L2 es el resultado de eliminar los primeros N elementos de L1.
*/
drop(0,Last_elements,Last_elements) :- !.
drop(N,[_|Tail],Last_elements) :-
    N > 0,
    N1 is N  - 1,
    drop(N1,Tail,Last_elements).

/*
 * take_sublist(Begin, End, L1, L2).
 * Predicado que es true si L2 es el resultado de tomar los elementos de L1 que estan en las posiciones entre
 * los indices Begin y End (incliyendo a estos).
 * El conteo de los indices empieza en 1.
*/
take_sublist(Begin,End, List, Z ):-
    B2 is Begin - 1,
    E2 is End - Begin + 1,
    drop(B2, List, Z1),
    take(E2, Z1, Z).

/*
 * replace(L, L1, X, L2).
 * Predicado que es true si L2 es el resultado de reemplaza en la lista L1 el elemento en
 * la posicion K con el valor X.
*/
replace(0, [_|T], X, [X|T]):- !.
replace(K, [H|T], X , Z):-
    K > 0,
    K2 is K -1,
    replace(K2, T, X, T1),
    Z = [H|T1].

/*
 * path_with_max_fitness(S, N, Pos_inicial, Z).
 * Predicado que es true si Z es un par (T,S1) donde F es el maximo fitness value de un elemento de S
 * en un tablero de longitud NxN, y S1 es la secuencia asociado a ese maximo fitness value.
*/
path_with_max_fitness([Sequence], N, Pos_inicial, Z):-
    fitness_value(Sequence, Pos_inicial, N, Fit_value),
    Z = ( Fit_value, Sequence).

%- Caso cuando hay mas de una secuencia de movimientos.
path_with_max_fitness([H|T], N, Pos_inicial, Z):-
    %- buscamos recursicamente
    path_with_max_fitness(T, N, Pos_inicial, (Curret_fit , Current_seq) ),!,
    %- calculamos el fitness value de la secuencia actual
    fitness_value(H, Pos_inicial, N, Fit_value),
    %- Elegimos la secuencia con mayor fitness value
    (
        Fit_value > Curret_fit -> Z =  (Fit_value, H);
        Z = (Curret_fit, Current_seq)
    ).


/*
 * get_all_fit_values(L1, N, Pos_inicial, L2).
 * Predicado que es tru si L1 es una lista de secuencias de patrones de movimientos, y L2 es la lista
 * de fitness values asociados a los elementos de L1 para un tablero de NxN con Pos_inicial siendo la
 * posicion de inicio.
*/
get_all_fit_values([], _, _, []).
get_all_fit_values([H|T], N, Pos_inicial, Z):-
    get_all_fit_values(T, N, Pos_inicial, Z1),
    fitness_value(H, Pos_inicial, N, Fit1),
    Z = [Fit1|Z1].


/*
 * sum_all_fit_values(L, N, Pos_inicial, Z).
 * Predicado que es true si Z es la suma de todos los fitnes value asociados a las secuencias en la lista L en un
 * tablero con N la longitud de un lado, y Pos_inicial como posicion de inicio.
*/
sum_all_fit_values([], _, _, 0).
sum_all_fit_values([H|T], N, Pos_inicial, Z):-
    sum_all_fit_values(T, N, Pos_inicial, Z1),!,
    fitness_value(H, Pos_inicial, N, Fit1),
    Z is Z1 + Fit1.


/*
 * take_best_merge(S1, S2, N, Pos_inicial, Z).
 * Predicado que es true si S1 y S2 son secuencias de patrones de movimentos, y Z es la secuencia entre
 * S1 y el merge de S1 con S2 que tenga mayor fitness value en un tablero de NxN con posicion de
 * inicio Pos_inicioa.
*/
take_best_merge(Seq1, Seq2, N, Pos_inicial, New_seq):-
    Longitud is N * N -1,
    merge_solution(Seq1, Seq2, Longitud, Seq3),
    %- calculamos el fitness value de la secuancia antes de ser modificada
    fitness_value(Seq1, Pos_inicial, N, F1),
    %- obtenemos el fitness value de la secuencia modificada
    fitness_value(Seq3, Pos_inicial, N, F2),
    %- nos quedamos con la secuencia con mayor fitness value
    (
        F1 < F2 -> New_seq = Seq3 ;
        New_seq = Seq1
    ).


/*
 * delete_one(X, L, Z).
 * Predicado que es true si Z es el resultado de eliminar la primera ocurrencia de X en la lista L.
*/
delete_one(X, [X|T],T):- !.
delete_one(X,[H|T],Z):-
    delete_one(X,T, Z1),
    Z = [H|Z1].


/*
 * from_source_to_path(N, Pos_actual, Num_mov, L, Z)
 * Predicado que es true si N el la longitud del lado del tablero, Pos_actual es la posicion
 * donde se encuentra la pieza actualmente, Num_mov es la cantidad de movimientos validos restantes
 * por realizar, L la secuencia de patrones de movimientos y Z el camino recorrido con los patrones
 * de L.
*/
from_source_to_path(_, 0, _, []):- !.
from_source_to_path(Pos_actual, Num_mov, [H|T], Z ):-
    Num_mov > 0,
    Num2 is Num_mov - 1,
    %- realizamos el movimiento actual
    move_pattern(H, Pos_actual, New_pos ),
    %- obtenemos recursivamente y creamos el camino completo
    from_source_to_path(New_pos, Num2, T, Z1 ),
    Z = [New_pos|Z1].
