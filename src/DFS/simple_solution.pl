:- set_prolog_flag(answer_write_options,[max_depth(0)]).

/*
 * find_max_length( Pos_inicial, N, Z).
 * Predicado que es true si Pos_inicial es un par que representa la posicion de inicio, N es la longitud
 * del lado del tablero y Z es un par de la forma (L, P) donde L es la longitud del camino P, y P es el
 * camino mas largo posible con movimientos del caballo sin repetir casillas.
*/
find_max_length( Pos_inicial, N , Z):-
    %- se buscan todos los caminos guardando el de maxima longitud siempre
    aggregate_all(max(X, Path), X , length_path([Pos_inicial], Pos_inicial, N, X, Path), Z1),
    %- este match es solo para darle un formato de salida mas limpio
    Z1 = max(Z2, Z3),
    Z = (Z2,Z3).


/*
 * length_path(Visited, Pos, N, Length, Path_result).
 * Predicado que es true si Pos es la posicion inicial, N el tamanio del lado del tablero
 * Visited las casillas visitadas hasta ese punto y Length es la longitud del camino Path_result
*/
length_path(Visited, Pos, N, Length, Path_result):-
    next_mov(Visited, Pos, N, New_pos),
    length_path( [New_pos|Visited] , New_pos, N, New_length, Path_result2),
    append([New_pos], Path_result2, Path_result),
    Length is New_length + 1.

length_path(Visited, Pos, N, Length, Path_result):-
    \+ next_mov(Visited, Pos, N, _),
    Path_result = [],
    Length = 0.


/*
 * next_move( Visited, Pos, N, New_pos).
 * Predicado que es true si Visited es la lista de posiciones visitadas hasta ese momento, Pos es la posicion actual,
 * N el tamanio del lado del tablero y New_pos es una posicion a la que se llega con un movimiento valido.
*/
next_mov( Visited, Pos, N, New_pos) :-
    movement(Pos, N, New_pos),
    not(member(New_pos, Visited)).


/*
 * movement( (X,Y), N, R ).
 * Predicado que es true si (X, Y) es la posicion en el tablero, N el tamanio del lado del tablero y R es
 * la posicion resultante resultado de realizar un movimiento del caballo. Los valores obtenidos
 * pueden contener numeros negativos invalidos.
*/
movement( (X,Y) , N, R ):-
    X2 is X + 1,
    Y2 is Y + 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X - 1,
    Y2 is Y + 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X + 2,
    Y2 is Y + 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X - 2,
    Y2 is Y + 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X + 1,
    Y2 is Y - 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X - 1,
    Y2 is Y - 2,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X + 2,
    Y2 is Y - 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).

movement( (X,Y) , N, R ):-
    X2 is X - 2,
    Y2 is Y - 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    R = (X2,Y2).
