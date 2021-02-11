:-[movements].

% Predicado que es true si N es un numero natural y Z es una lista de longitud (N^2)-1 con numeros random entre [1,8].
random_init(N, Z):-
    Square is N * N,
    Longitud is Square -1,
    length(Z, Longitud),
    maplist( random(1,9), Z).


%- Predicado que es true si Z es el valor que toma la funcion fitness para la secuencia S
fitness_value(S, PosInicial, N,  Z):-
    fitness_value_aux(S, [PosInicial], PosInicial, N, Z).

fitness_value_aux([], _, _, _, 0).

fitness_value_aux([H|T] , Visited,  PosInicial, N, Z):-
    valid_move( Visited , PosInicial, H, N,  PosFinal),
    fitness_value_aux( T, [PosFinal | Visited] , PosFinal,N, Z1),!,
    Z is Z1 + 1.

fitness_value_aux([H|_] , Visited,  PosInicial, N,  Z):-
    \+ valid_move([PosInicial|Visited], PosInicial, H, N , _),
    Z is 0.

take(0, _, []) :- !.
take(N, [H|TA], [H|TB]) :-
    N > 0,
    N2 is N - 1,
    take(N2, TA, TB).

drop(0,LastElements,LastElements) :- !.
drop(N,[_|Tail],LastElements) :-
    N > 0,
    N1 is N  - 1,
    drop(N1,Tail,LastElements).

take_sublist(Begin,End, List, Z ):-
    B2 is Begin - 1,
    E2 is End - Begin + 1,
    drop(B2, List, Z1),
    take(E2, Z1, Z).


%- Predicado que es true si Z es el resultado de reemplaza en la lista [H|T] el elemento en
%- la posicion K con el valor X.
replace(0, [_|T], X, [X|T]):- !.
replace(K, [H|T], X , Z):-
    K > 0,
    K2 is K -1,
    replace(K2, T, X, T1),
    Z = [H|T1].


%-- Predicado que es true si Z es un par donde el primer elemento es el maximo fitness value y el segundo elemento
% -- es el camino asociado a ese maximo fitness value
path_with_max_fitness([Sequence], N, Pos_inicial, Z):-
    fitness_value(Sequence, Pos_inicial, N, Fit_value),
    Z = ( Fit_value, Sequence).

path_with_max_fitness([H|T], N, Pos_inicial, Z):-
    path_with_max_fitness(T, N, Pos_inicial, (Curret_fit , Current_seq) ),!,
    fitness_value(H, Pos_inicial, N, Fit_value),
    (
        Fit_value > Curret_fit -> Z =  (Fit_value, H);
        Z = (Curret_fit, Current_seq)
    ).

%- Predicado que es true si Z es la suma de todos los fitnes value asociados a las secuencias en la lista [H|T]
sum_all_fit_values([], _, _, 0).
sum_all_fit_values([H|T], N, Pos_inicial, Z):-
    sum_all_fit_values(T, N, Pos_inicial, Z1),!,
    fitness_value(H, Pos_inicial, N, Fit1),
    Z is Z1 + Fit1.

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
