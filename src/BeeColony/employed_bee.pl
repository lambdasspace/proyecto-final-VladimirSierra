:-[compute].

update_solution(Old_solution, Neighboring_solution, Longitud, New_solution):-
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



generate_cut_points(Longitud, Z):-
    random(1, Longitud, R1),
    random(1, Longitud, R2),
    random(1, Longitud, R3),
    (   R1 \= R2,
        R2 \= R3,
        R1 \= R3 -> sort([R1,R2,R3],Z) ;
        generate_cut_points(Longitud, Z)
    ).
