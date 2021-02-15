:- set_prolog_flag(answer_write_options,[max_depth(0)]).


/*
 * find_max_length( N, Pos_inicial,  Z).
 * Predicado que es true si Pos_inicial es un par que representa la posicion de inicio, N es la longitud
 * del lado del tablero y Z es un par de la forma (L, P) donde L es la longitud del camino P, y P es el
 * camino mas largo posible con movimientos del caballo sin repetir casillas.
*/
find_max_length(N, Pos_inicial, Z):-
    %- buscamos el camino con la heuristica, cortamos para evitar ramas de fallo.
    length_path([Pos_inicial], Pos_inicial, N, Length, Path),!,
    Z = (Length, [Pos_inicial|Path]).



/*
 * length_path(Visited, Pos, N, Length, Path_result).
 * Predicado que es true si Pos es la posicion inicial, N el tamanio del lado del tablero
 * Visited las casillas visitadas hasta ese punto y Length es la longitud del camino Path_result
*/
length_path(Visited, Pos, N, Lenght, PathResult):-
    warnsdorff_rule( Pos, N, Visited, New_pos),
    length_path( [New_pos|Visited] , New_pos, N, New_lenght, PathResult2),
    append([New_pos], PathResult2, PathResult),
    Lenght is New_lenght + 1.

length_path(Visited, Pos, N, Lenght, PathResult):-
    \+ warnsdorff_rule( Pos, N, Visited, _),
    PathResult = [],
    Lenght = 0.



/*
 * warnsdorff_rule( (X,Y), N, Visited, Z).
 * Predicado que es true si (X,Y) es una posicion en el tablero, N es la longitud del lado del tablero,
 * Visited es la lista de casillas visitadas hasta ese momento y Z la siguiente casilla a visitar siguiendo
 * la regla de Warnsdorff.
*/
warnsdorff_rule((X,Y), N, Visited, Z):-
    bagof( C, (movement((X,Y), N, C) , not(member(C, Visited))), Z1 ),
    warnsdorff_rule_aux(Z1, N, Visited, Z).

/*
 * warnsdorff_rule_aux( L , N, Visited, Z).
 * Predicado auxiliar que es true si L es la lista de potenciales siguientes casillas a visitar, N es la longitud
 * del lado del tablero, Visited es la lista de casillas visitadas hasta ese momento, y Z es el elemento de L
 * que tiene una menor cantidad de casillas adyacentes no visitadas.
*/
warnsdorff_rule_aux([X], _ , _, X):- !.
warnsdorff_rule_aux([H|T], N, Visited, Z):-
    warnsdorff_rule_aux(T,N,Visited, Z1),
    count_adjacent_unvisited(Z1, N, Visited, C1),
    count_adjacent_unvisited(H, N, Visited, C2),
    (C1 > C2 -> Z = H ;  Z = Z1 ).



/*
 * count_adjacent_unvisited( (X,Y), N, Visited, Z).
 * Predicado que es true si (X,Y) es una casilla del tablero de longitud NxN, Visited es la lista de casillas
 * visitadas hasta ese momento, y Z es la cantidad de casillas adyacentes a (X,Y) que no han sido visitadas.
*/
count_adjacent_unvisited( (X,Y), N, Visited, Z):-
    %- guardamos en Z1 las casillas adyacentes a (x,y) que no hayan sido visitadas
    bagof( C,
            (
                movement( (X,Y), N, C),
                not(member(C, Visited))
            ),
         Z1),
    %- contamos las casillas que cumplieron con la condicion
    length(Z1, Z).



/*
 * next_move( Visited, Pos, N, New_pos).
 * Predicado que es true si Visited es la lista de posiciones visitadas hasta ese momento, Pos es la posicion actual,
 * N el tamanio del lado del tablero y New_pos es una posicion a la que se llega con un movimiento valido.
*/
next_mov( Visited, Pos, N, NewPos) :-
    movement(Pos, N, NewPos),
    not(member(NewPos, Visited)).


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
