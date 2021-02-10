:- set_prolog_flag(answer_write_options,[max_depth(0)]).
:- [compute].

numEmployedBees(120).
num_repeticiones(1000).


%- Predicado que es true si N es un numero natural y Z es la lista que guarda la representacion de una fuente de comida.
generate_employed_bees(1, N, Z):-
    random_init(N, Z1),!,
    Z = [Z1].

generate_employed_bees(Num_emp_bees, N, Z):-
    Num_emp_bees > 1,
    Num2 is Num_emp_bees - 1,
    generate_employed_bees(Num2, N, Z1),
    random_init(N, Z2),
    Z = [Z2 | Z1].

update_suorce_food(_,_):- !.


