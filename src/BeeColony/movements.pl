valid_move(Visited, PosInicial, MoveId ,N,  (X,Y) ):-
    move_patter(MoveId, PosInicial, (X,Y)),
    X >= 1,
    Y >= 1,
    X =< N,
    Y =< N,
    not(member((X,Y), Visited)).

%- Predicado que es true si PosFinal es la posicion final de la pieza al aplicar el movimento con id 1
move_patter(1, (X,Y) , PosFinal):-
    X2 is X + 1,
    Y2 is Y - 2,
    PosFinal = (X2, Y2).

move_patter(2, (X, Y), PosFinal):-
    X2 is X + 2,
    Y2 is Y - 1,
    PosFinal = (X2, Y2).


move_patter(3, (X, Y), PosFinal):-
    X2 is X + 2,
    Y2 is Y + 1,
    PosFinal = (X2, Y2).

move_patter(4, (X, Y), PosFinal):-
    X2 is X + 1,
    Y2 is Y + 2,
    PosFinal = (X2, Y2).

move_patter(5, (X, Y), PosFinal):-
    X2 is X - 1,
    Y2 is Y + 2,
    PosFinal = (X2, Y2).
move_patter(6, (X, Y), PosFinal):-
    X2 is X - 2,
    Y2 is Y + 1,
    PosFinal = (X2, Y2).
move_patter(7, (X, Y), PosFinal):-
    X2 is X - 2,
    Y2 is Y - 1,
    PosFinal = (X2, Y2).
move_patter(8, (X, Y), PosFinal):-
    X2 is X - 1,
    Y2 is Y - 2,
    PosFinal = (X2, Y2).
