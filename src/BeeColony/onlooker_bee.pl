:-[employed_bee].
:-[compute].

onlooker_bees_job(L, N, Pos_inicial,  Z):-
    Longitud is N * N - 1,
    sum_all_fit_values(L, N, Pos_inicial, Sum_fit),
    onlooker_update_all_solutions(L,L,N, Longitud,Pos_inicial, Sum_fit, Z).




onlooker_update_all_solutions([],_, _, _, _, _, []).
onlooker_update_all_solutions([H|T], Complete_list, N, Longitud, Pos_inicial, Sum_fit, Z):-
    %-- aplicamos recursivamente sobre la cola
    onlooker_update_all_solutions(T, Complete_list, N, Longitud, Pos_inicial, Sum_fit, Z1),
    %- calculamos el fitness value de la cabeza
    fitness_value(H, Pos_inicial, N, Fit1),
    Sum_plus is Sum_fit + 1,
    %decidimos si modificar o no
    random(Sum_fit, Sum_plus , R1),
    (
        R1 =< Fit1 -> (
            delete(Complete_list,H, L1),
            random_member(X, L1),
            take_best_merge(H, X, N, Pos_inicial, H1),
            Z = [H1|Z1]
        ) ;
        Z = [H|Z1]
    ).




