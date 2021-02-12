# IMPLEMENTACION AUN EN MODIFICACION. NO LA TOME EN CUENTA COMO ENTREGA FINAL.
# The Knight's Tour

## Alumno: Sierra Casiano Vladimir

### Definición del problema:
Dado un tablero de NxN y una posición inicial se desea encontrar
el camino más largo con movimientos válidos de tal manera que 
cada casilla es visitada a lo más una vez.



## Como ejecutar el programa.

#### Ejecucion de solucion con ABC.

1. Ingrese a la carpeta src/BeeColony.
2. Ejecute en una terminal el comando

        $> swipl bee_colony.pl
        
3. Las consultas se hacen con el predicado

        bee_algorithm(N, Pos_inicial, Repeticiones, Num_abejas, Z).
    
    donde N es el tamaño del lado del tablero, Pos_inicial es la posicion
    de inicio de la pieza siguiendo un formato de '(X,Y)', Repeticiones 
    es el numero de iteraciones que se desea reliazar y Num_abejas
    el numero de agentes.
    
    Por ejemplo, para un tablero de 3x3 con casilla inicial la esquina 
    superior izquierda, haciendo 300 iteraciones con 200
    agentes la consulta es la siguiente
    
        ?- bee_algorithm(3, (1,1) , 300 , 200, Z).
