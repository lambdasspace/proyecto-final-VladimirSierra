/*
 * valid_move( Visited, Pos_inicial, Move_id, N, (X,Y) ).
 * Predicado que es true si Visited son las casillas visitadas hasta ese momento, Pos_inicial la posicion actual de la
 * pieza, N la longitud del lado del tablero, y (X,Y) es una posicion final valida aplicando el movimiento Move_id
*/
valid_move(Visited, PosInicial, MoveId ,N,  (X,Y) ):-
    move_pattern(MoveId, PosInicial, (X,Y)),
    X >= 1,
    Y >= 1,
    X =< N,
    Y =< N,
    not(member((X,Y), Visited)).


/*
 * move_pattern( K , (X,Y), Pos_final
 * Predicado que es true si Pos_final es la posicion final de la pieza al aplicar el movimento con id K
 * empezando en la posicion (X,Y).
*/
move_pattern(1, (X,Y) , Pos_final):-
    X2 is X + 1,
    Y2 is Y - 2,
    Pos_final = (X2, Y2).
move_pattern(2, (X, Y), Pos_final):-
    X2 is X + 2,
    Y2 is Y - 1,
    Pos_final = (X2, Y2).
move_pattern(3, (X, Y), Pos_final):-
    X2 is X + 2,
    Y2 is Y + 1,
    Pos_final = (X2, Y2).
move_pattern(4, (X, Y), Pos_final):-
    X2 is X + 1,
    Y2 is Y + 2,
    Pos_final = (X2, Y2).
move_pattern(5, (X, Y), Pos_final):-
    X2 is X - 1,
    Y2 is Y + 2,
    Pos_final = (X2, Y2).
move_pattern(6, (X, Y), Pos_final):-
    X2 is X - 2,
    Y2 is Y + 1,
    Pos_final = (X2, Y2).
move_pattern(7, (X, Y), Pos_final):-
    X2 is X - 2,
    Y2 is Y - 1,
    Pos_final = (X2, Y2).
move_pattern(8, (X, Y), Pos_final):-
    X2 is X - 1,
    Y2 is Y - 2,
    Pos_final = (X2, Y2).
