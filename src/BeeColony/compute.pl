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
