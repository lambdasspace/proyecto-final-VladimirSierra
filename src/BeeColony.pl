:- set_prolog_flag(answer_write_options,[max_depth(0)]).


random_init(N, Z):-
    Square is N * N,
    Longitud is Square -1,
    length(Z, Longitud),
    maplist( random(1,9), Z).

generate_employed_bees(1, N, Z):-
    random_init(N, Z1),!,
    Z = [Z1].

generate_employed_bees(Num_emp_bees, N, Z):-
    Num2 is Num_emp_bees - 1,
    generate_employed_bees(Num2, N, Z1),
    random_init(N, Z2),
    Z = [Z2 | Z1].

update_suorce_food(X,Z):- !.

