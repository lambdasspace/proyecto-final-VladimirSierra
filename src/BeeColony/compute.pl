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
