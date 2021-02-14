:-[employed_bee].
:-[compute].

/*
 * onlooker_bees_job(L, N, Pos_inicial, Z).
 * Predicado que es true si L es la lista de fuentes de comida, N la longitud del lado del tablero, Pos_inicial la posicion de inicio y Z
 * es el resultado de actualizar las fuentes escogidas por las abejas observadoras.
*/
onlooker_bees_job(L, N, Pos_inicial,  Z):-
    Longitud is N * N - 1,
    length(L, Num_bees),
    %- Caso cuando la suma de valores fit es mayor a 0
    sum_all_fit_values(L, N, Pos_inicial, Sum_fit),
    Sum_fit > 0,
    get_all_fit_values(L, N , Pos_inicial, Fit_vals),
    onlooker_selection(L, Fit_vals, Sum_fit, Num_bees, L2 ),!,
    %- eliminamos selcciones repetidas
    list_to_set(L2,L3),
    subtract(L, L3, L4),
    %- actualizamos las soluciones seleccionadas
    update_all_solutions(L3 , L, N, Longitud,Pos_inicial, Z1),
    %- juntamos las fuentes actualizadas con las no actualizadas
    append(L4,Z1,Z).


onlooker_bees_job(L, N, Pos_inicial,  Z):-
    Longitud is N * N - 1,
    length(L, Num_bees),
    %- caso cuando la suma es 0, se escoge uniformemente
    sum_all_fit_values(L, N, Pos_inicial, Sum_fit),
    Sum_fit = 0,
    onlooker_equal_selection(L, Num_bees, L2 ),!,
    %- separamos las abejas seleccionadas
    list_to_set(L2,L3),
    subtract(L, L3, L4),
    %- actualizamos las fuentes escogidas y al final las juntamos con las no modificadas
    update_all_solutions(L3 , L, N, Longitud,Pos_inicial, Z1),
    append(L4, Z1, Z).




/*
 * onlooker_equal_selection(L, K, Z).
 * Predicado que es true si L es una lista de fuentes de comida, K un numero natural y Z es el resultado de seleccionar
 * K elementos de L (elementos repetidos se permiten) aleatoriamente y uniformemente.
*/
onlooker_equal_selection(L, 1, Z):-
    random_member(Z1, L),
    Z = [Z1].

onlooker_equal_selection(L, N, Z):-
    N > 1,
    N2 is N - 1,
    onlooker_equal_selection(L, N2, Z1),
    random_member(H1, L),
    Z = [H1| Z1].


/*
 * onlooker_selection( L1, L2, S, K, Z).
 * Predicado que es true si L1 es una lista de fuentes de comida, L2 la lista de sus correspondientes fitness values, S la suma de todos los elementos
 * de L2, K el numero de elementos que se quieren seleccionar y Z la lista de los K elementos seleccionados.
*/
onlooker_selection(Seqs, Probs, Sum_fit, 1, Z):-
    select_with_prob(Seqs, Probs, Sum_fit, Z1),
    Z = [Z1].


onlooker_selection(Seqs, Probs, Sum_fit, Num_selections, Z):-
    Num_selections > 1,
    Num2 is Num_selections -1,
    onlooker_selection(Seqs, Probs, Sum_fit, Num2, Z1),!,
    select_with_prob(Seqs, Probs, Sum_fit, H1),
    Z = [H1|Z1].


/*
 * select_with_prob( Ls, Ps, Sf, Z).
 * Predicado que es true si Ls es una lista de fuentes de comida, Ps es la lista de fit values correspondiente a las fuentes,
 *  Sf es la suma de todos los valores en Ps y  Z es una fuente de comida escodigo aleatoriamente no uniformemente siguiendo
 * la funcion de probabilidad.
*/
select_with_prob( Seqs, Probs, Sum_fit, Z):-
    S1 is Sum_fit + 1,
    %- obtenemos un random en el rango y buscamos la secuencia a la que corresponde
    random(1, S1, R1),
    select_with_prob_aux(R1, Seqs, Probs, Z).


/*
 * select_with_prob_aux( R, L1, L2, Z).
 * Predicado auxiliar que es true si R es un numero random, L1 la lista de fuentes de comida, L2 los fitness value de los
 * elementos de L1 y Z es el elemento en L1 cuya suma acumulada de valores en L2 es menor o igual a R.
*/
select_with_prob_aux(Ran, [H|T], [PH|PT], Z):-
    (
        %- observamos si el numero random cae en los valores correspondientes a la secuencia H
        Ran =< PH -> Z = H;
        %- en caso contrario buscamos en la cola
        (
        Ran2 is Ran - PH,
        select_with_prob_aux(Ran2, T, PT, Z)
        )
    ).






