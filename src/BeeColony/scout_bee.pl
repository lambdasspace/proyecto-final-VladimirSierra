:- [movements].
:- [compute].

scout_bee_job(Secuence, N, Pos_inicial, New_secuence):-
    extend_solution(Secuence, N, Pos_inicial, New_secuence),!.

scout_bee_job(Secuence, N, Pos_inicial, New_secuence):-
    \+ extend_solution(Secuence, N, Pos_inicial, _),
    random_init(N, New_secuence).



extend_solution(Sequence, N, Pos_inicial, New_sequence):-
    %- caso cuando el fitness value ya es el maximo.
    Limit is N * N - 1,
    apply_sequence(Sequence, N,  (Pos_inicial, 0, [Pos_inicial]), (_, FV_final, _)),
    FV_final = Limit,
    New_sequence = Sequence.


extend_solution(Sequence, N, Pos_inicial, New_sequence):-
    %- caso cuando se puede aumentar el fitness value actual
    Limit is N * N - 1,
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



