:-[compute].

/*
 * generate_employed_bees(K, N, Z).
 * Predicado que es true si N es un numero natural que sera la longitud del tablero,  Z es la lista que guarda la
 * representacion de K fuentes de comida.
*/
generate_employed_bees(1, N, Z):-
    random_init(N, Z1),!,
    Z = [Z1].

generate_employed_bees(Num_emp_bees, N, Z):-
    Num_emp_bees > 1,
    Num2 is Num_emp_bees - 1,
    generate_employed_bees(Num2, N, Z1),
    random_init(N, Z2),
    Z = [Z2 | Z1].

/*
 * employed_bees_job(L, N, Pos_inicial, Z).
 * Predicado que es true si L es la lista de fuentes de comida, N la longitud del lado del tablero,
 * Pos_inicial es la posicion de inicio del recorrido y Z es el resultado de que todas las abejas empleadas
 * realicen su tarea.
*/
employed_bees_job(L, N, Pos_inicial,  Z):-
    Longitud is N * N - 1,
    update_all_solutions(L,L,N, Longitud,Pos_inicial, Z).


/*
 * merge_solution(S1, S2, L, Z).
 * Predicado que es true si S1 y S2 son listas de patrones de movimientos, L es la longitud de S1 y S2, y Z es
 * el resultado de mezclar S1 con S2 con la tecnica Three point switch.
*/
merge_solution(Old_solution, Neighboring_solution, Longitud, New_solution):-
    %- primero generamos los tres puntos random de corte
    generate_cut_points(Longitud, [P1,P2,P3]),
    %- algunos valores auxiliares
    P1_added is P1 + 1,
    P2_added is P2 + 1,
    P3_added is P3 + 1,
    %- tomamos los segmentos de las dos soluciones dadas para la nueva solution
    take_sublist(1, P1, Old_solution, Segmento1),
    take_sublist(P1_added, P2, Neighboring_solution, Segmento2),
    take_sublist(P2_added, P3, Old_solution, Segmento3),
    take_sublist(P3_added, Longitud, Neighboring_solution, Segmento4),
    %- unimos los segmentos obtenodos
    append([Segmento1, Segmento2, Segmento3, Segmento4], New_solution).


/*
 * generate_cut_point(L, Z).
 * Predicado que es true si Z es una lista de tres puntos diferentes ordenados de menor a mayor
 * que se encuentran en un rango [1,L].
*/
generate_cut_points(Longitud, Z):-
    random(1, Longitud, R1),
    random(1, Longitud, R2),
    random(1, Longitud, R3),
    (
        %- ordenamos los puntos de ser necesario
        R1 \= R2,
        R2 \= R3,
        R1 \= R3 -> sort([R1,R2,R3],Z) ;
        %- en caso de obtener puntos iguales repetimos hasta obtener diferentes
        generate_cut_points(Longitud, Z)
    ).


/*
 * update_all_solutions(L1, L2, N, Longitud, Pos_inicial, Z).
 * Predicado que es true si L1 es la lista de secuencias a modificar, L2 es la lista
 * de todas las secuencias elegibles para mutar, Longitud es la
*/
update_all_solutions([],_, _, _, _, []).
update_all_solutions([H|T], Complete_list, N, Longitud, Pos_inicial,  Z):-
    %- llamamos recursivamente
    update_all_solutions(T, Complete_list, N, Longitud, Pos_inicial, Z1),
    %- evitamos que se elijan a si mismas
    delete_one( H, Complete_list, L1),
    random_member(X, L1),
    %-- hacemos el merge de ambas secuencias y decidimos greedy
    take_best_merge(H,X,N, Pos_inicial, H1),
    Z = [H1|Z1].









