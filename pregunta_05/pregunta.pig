/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.tsv' USING PigStorage('\t')
    AS (
            mayuscula:chararray,
            minuscula:chararray,
            caracteres:int          
        ); 

filtro1 = FOREACH datos GENERATE minuscula;

filtro2 = FOREACH filtro1 GENERATE FLATTEN(TOKENIZE(minuscula)) as letra; 

filtro3 = FILTER filtro2 BY (letra MATCHES '.*[a-z].*');

filtro4 = GROUP filtro3 BY letra; 

filtro5= FOREACH filtro4 GENERATE group, COUNT(filtro3); 


STORE filtro5 INTO 'output/' USING PigStorage(',');