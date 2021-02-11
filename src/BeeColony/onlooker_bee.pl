:-[employed_bee].
:-[compute].

onlooker_bees_job(L, N, Pos_inicial,  Z):-
    Longitud is N * N - 1,
    length(L, Num_bees),
    sum_all_fit_values(L, N, Pos_inicial, Sum_fit),
    Sum_fit > 0,
    get_all_fit_values(L, N , Pos_inicial, Fit_vals),
    onlooker_selection(L, Fit_vals, Sum_fit, Num_bees, L2 ),!,
    update_all_solutions(L2 , L, N, Longitud,Pos_inicial, Z).


onlooker_bees_job(L, N, Pos_inicial,  Z):-
    Longitud is N * N - 1,
    length(L, Num_bees),
    sum_all_fit_values(L, N, Pos_inicial, Sum_fit),
    Sum_fit = 0,
    onlooker_equal_selection(L, Num_bees, L2 ),!,
    update_all_solutions(L2 , L, N, Longitud,Pos_inicial, Z).


onlooker_equal_selection(L, 1, Z):-
    random_member(Z1, L),
    Z = [Z1].

onlooker_equal_selection(L, N, Z):-
    N > 1,
    N2 is N - 1,
    onlooker_equal_selection(L, N2, Z1),
    random_member(H1, L),
    Z = [H1| Z1].

onlooker_selection(Seqs, Probs, Sum_fit, 1, Z):-
    select_with_prob(Seqs, Probs, Sum_fit, Z1),
    Z = [Z1].


onlooker_selection(Seqs, Probs, Sum_fit, Num_selections, Z):-
    Num_selections > 1,
    Num2 is Num_selections -1,
    onlooker_selection(Seqs, Probs, Sum_fit, Num2, Z1),!,
    select_with_prob(Seqs, Probs, Sum_fit, H1),
    Z = [H1|Z1].



select_with_prob( Seqs, Probs, Sum_fit, Z):-
    S1 is Sum_fit + 1,
    random(1, S1, R1),
    select_with_prob_aux(R1, Seqs, Probs, Z).

select_with_prob_aux(Ran, [H|T], [PH|PT], Z):-
    (
        Ran =< PH -> Z = H;
        (
        Ran2 is Ran - PH,
        select_with_prob_aux(Ran2, T, PT, Z)
        )
    ).

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




