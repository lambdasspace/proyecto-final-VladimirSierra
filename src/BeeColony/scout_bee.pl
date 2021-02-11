:- [movements].
:- [compute].

scout_bees_job(L, N, Pos_inicial, Z):-
    path_with_max_fitness(L, N, Pos_inicial, (Limit,_) ),
    scout_job_aux(L, N, Pos_inicial, Limit, Z).

scout_job_aux([], _ , _, _, []).
scout_job_aux([H|T], N, Pos_inicial, Limit, Z):-
    scout_job_aux(T, N, Pos_inicial, Limit, Z1),
    scout_update_sequence(H, N, Pos_inicial, Limit, H1),
    Z = [H1| Z1].



scout_update_sequence(Secuence, N, Pos_inicial, Limit, New_secuence):-
    extend_solution(Secuence, N, Pos_inicial,Limit, New_secuence),!.

scout_update_sequence(Secuence, N, Pos_inicial, Limit, New_secuence):-
    \+ extend_solution(Secuence, N, Pos_inicial,Limit,  _),
    random_init(N, New_secuence).



extend_solution(Sequence, N, Pos_inicial, Limit, New_sequence):-
    %- caso cuando el fitness value ya es el maximo.
    apply_sequence(Sequence, N,  (Pos_inicial, 0, [Pos_inicial]), (_, FV_final, _)),
    FV_final = Limit,
    New_sequence = Sequence.


extend_solution(Sequence, N, Pos_inicial,Limit, New_sequence):-
    %- caso cuando se puede aumentar el fitness value actual
    apply_sequence(Sequence, N,  (Pos_inicial, 0, [Pos_inicial]), (Pos_final, FV_final, Visited_final)),
    FV_final < Limit,
    %- Obtenemos el primer movimiento invalido
    nth0(FV_final, Secuense, Replace ),
    %- Buscamos un patro de movimiento distinto para aumentar el futness value
    between(1,8, New_pattern),
    New_pattern \= Replace,
    valid_move(Visited_final, Pos_final, New_pattern, N, _),
    %- Obtenemos la nueva secuencia reemplazando el viejo patron de movimento por el nuevo
    replace(FV_final, Secuense, New_pattern, New_sequence).





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



