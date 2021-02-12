:- set_prolog_flag(answer_write_options,[max_depth(0)]).

find_max_lenght( Pos_inicial, N , Z):-
    max_length_path([Pos_inicial], Pos_inicial, N, Length, Path),!,
    Z = (Length, [Pos_inicial|Path]).



max_length_path(Visited, Pos, N, Lenght, PathResult):-
    choose_best_move( Pos, N, Visited, New_pos),
    max_length_path( [New_pos|Visited] , New_pos, N, New_lenght, PathResult2),
    append([New_pos], PathResult2, PathResult),
    Lenght is New_lenght + 1.

max_length_path(Visited, Pos, N, Lenght, PathResult):-
    \+ choose_best_move( Pos, N, Visited, _),
    PathResult = [],
    Lenght = 0.


count_adjacent_unvisited( (X,Y), N, Visited, Z):-
    %- guardamos en Z1 las casillas adyacentes a (x,y) que no hayan sido visitadas
    bagof( C,
            (
                adjacent_square( (X,Y), N, C),
                not(member(C, Visited))
            ),
         Z1),
    %- contamos las casillas que cumplieron con la condicion
    length(Z1, Z).


choose_best_move((X,Y), N, Visited, Z):-
    bagof( C, (movimiento_valido((X,Y), N, C) , not(member(C, Visited))), Z1 ),
    choose_best_move_aux(Z1, N, Visited, Z).

choose_best_move_aux([X], _ , _, X):- !.
choose_best_move_aux([H|T], N, Visited, Z):-
    choose_best_move_aux(T,N,Visited, Z1),
    count_adjacent_unvisited(Z1, N, Visited, C1),
    count_adjacent_unvisited(H, N, Visited, C2),
    (C1 > C2 -> Z =Z1 ;  Z = H ).



adjacent_square( (X,Y), N, Z):-
    X2 is X -1,
    Y2 is Y -1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    Z = (X2,Y2).

adjacent_square( (X,Y), N, Z):-
    Y2 is Y -1,
    Y2 >= 1,
    Y2 =< N,
    Z = (X,Y2).

adjacent_square( (X,Y), N, Z):-
    X2 is X + 1,
    Y2 is Y -1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    Z = (X2,Y2).

adjacent_square( (X,Y), N, Z):-
    X2 is X -1,
    X2 >= 1,
    X2 =< N,
    Z = (X2,Y).

adjacent_square( (X,Y), N, Z):-
    X2 is X + 1,
    X2 >= 1,
    X2 =< N,
    Z = (X2,Y).

adjacent_square( (X,Y), N, Z):-
    X2 is X - 1,
    Y2 is Y + 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    Z = (X2,Y2).

adjacent_square( (X,Y), N, Z):-
    Y2 is Y + 1,
    Y2 >= 1,
    Y2 =< N,
    Z = (X,Y2).
adjacent_square( (X,Y), N, Z):-
    X2 is X + 1,
    Y2 is Y + 1,
    X2 >= 1,
    Y2 >= 1,
    X2 =< N,
    Y2 =< N,
    Z = (X2,Y2).


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
