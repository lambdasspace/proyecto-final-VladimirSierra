max_length_path(Visited, Pos, N, Lenght):-
    next_mov(Visited, Pos, N, NewPos),
    max_length_path( [NewPos|Visited] , NewPos, N, New_lenght),
    Lenght is New_lenght + 1.

max_length_path(Visited, Pos, N, Lenght):-
    \+ next_mov(Visited, Pos, N, NewPos),
    Lenght = 0.


% Predicado que recibe la posicion inicial y calcula el camino mas largo del caballo
solve_problem( (1,2), Result):-
    max_length_path([], Pos, 0).

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
