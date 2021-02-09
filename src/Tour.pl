:- set_prolog_flag(answer_write_options,[max_depth(0)]).

find_max_lenght( PosInicial, N , Z):-
    aggregate_all(max(X), max_length_path([PosInicial], PosInicial, N, X, Path), Z ).



max_length_path(Visited, Pos, N, Lenght, PathResult):-
    next_mov(Visited, Pos, N, NewPos),
     max_length_path( [NewPos|Visited] , NewPos, N, New_lenght, PathResult2),
     append([NewPos], PathResult2, PathResult),
    Lenght is New_lenght + 1.

max_length_path(Visited, Pos, N, Lenght, PathResult):-
    \+ next_mov(Visited, Pos, N, _),
    PathResult = [],
    Lenght = 0.



% Predicado que es true si Visited es la lista de posiciones visitadas, Pos es la posicion actual, N el tamanio del lado
% del tablero y NewPos es una posicion a la que se llega con un movimiento valido.
next_mov( Visited, Pos, N, NewPos) :-
    movimiento_valido(Pos, N, NewPos),
    not(member(NewPos, Visited)).


movimiento_valido( (X,Y) , N, R ):-
    X2 is X + 1,
    Y2 is Y + 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X - 1,
    Y2 is Y + 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X + 2,
    Y2 is Y + 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X - 2,
    Y2 is Y + 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X + 1,
    Y2 is Y - 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X - 1,
    Y2 is Y - 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X + 2,
    Y2 is Y - 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movimiento_valido( (X,Y) , N, R ):-
    X2 is X - 2,
    Y2 is Y - 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).
