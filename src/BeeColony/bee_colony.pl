:- set_prolog_flag(answer_write_options,[max_depth(0)]).
:- [compute].
:-[employed_bee].

numEmployedBees(120).
num_repeticiones(1000).



bee_algorithm(N, Pos_inicial, Repeticiones, Num_abejas, Z):-
    generate_employed_bees(Num_abejas, N, Employed_bees),
    bee_alg_aux(Employed_bees, N, Pos_inicial, Repeticiones, Z).

bee_alg_aux(Solution, _, _, 1,Z):-
    Z = Solution, !.

bee_alg_aux(Partial_solutions, N, Pos_inicial, Repeticiones, Z):-
    Repeticiones > 1,
    R2 is Repeticiones - 1,
    employed_bees_job(Partial_solutions, N, Pos_inicial,  Z1),
    %- onlooker_bee_job(),
    %- scout_bee_job(),
    bee_alg_aux(Z1, N, Pos_inicial, R2, Z).
