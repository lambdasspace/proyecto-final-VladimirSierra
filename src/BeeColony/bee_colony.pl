%- Configuracion para mostrar soluciones completas.
:- set_prolog_flag(answer_write_options,[max_depth(0)]).
%- importes
:-[compute].
:-[movements].
:-[employed_bee].
:-[onlooker_bee].
:-[scout_bee].


/*
 * bee_algorithm(N, Pos_inicial, Repeticiones, Num_abejas, Z).
 * Predicado que es true si N es la longitud del lado del tablero, Pos_inicial es la posicion de inicio, Repeticiones
 * es el numero de iteraciones del algoritmo, Num_abejas es el numero de agentes y Z es un par de la forma (F, P)
 * donde F el la longitud de P, y P es el camino mas largo posible con movimientos validos del caballo.
*/
bee_algorithm(N, Pos_inicial, Repeticiones, Num_abejas,  (Fit, [Pos_inicial|Path] )):-
    %- generamos fuentes de comida de manera aleatoria
    generate_employed_bees(Num_abejas, N, Employed_bees),
    %- iteramos para obtener la secuencia de patrones de movimiento
    bee_alg_aux(Employed_bees, N, Pos_inicial, Repeticiones, (Fit, Seq) ),
    %- traducimos los patrones de movimientos a posiciones en el tablero
    from_source_to_path(Pos_inicial, Fit, Seq, Path ).

/*
 * bee_alg_aux(PS, N, Pos_inicial, K, Z).
 * Predicado que es true si N es la longitud del lado del tablero, Pos_inicial es la posicion de inicio, K es
 * el numero de iteracion actual, PS es la solucion parcial hasta esa iteracion y Z es la solucion global al final
 * de todas las iteraciones.
*/
bee_alg_aux(Solution, N, Pos_inicial, 1,Z):-
    %- Caso base, buscamos en la solucion acarreada por el camino mas largo
    path_with_max_fitness(Solution, N, Pos_inicial,Z),!.

%- Caso cuando faltan mas iteraciones.
bee_alg_aux(Partial_solutions, N, Pos_inicial, Repeticiones, Z):-
    Repeticiones > 1,
    R2 is Repeticiones - 1,
    %- Realizamos las tareas de los tres tipos de abejas por etapas
    employed_bees_job(Partial_solutions, N, Pos_inicial,  Z1),
    onlooker_bees_job(Z1, N, Pos_inicial,  Z2),!,
    scout_bees_job(Z2, N, Pos_inicial,  Z3),
    %- llamamos recursivamente
    bee_alg_aux(Z3, N, Pos_inicial, R2, Z).




my_append(A-B, B, A).
