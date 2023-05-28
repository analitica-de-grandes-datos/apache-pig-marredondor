/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Cuente la cantidad de personas nacidas por año.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
datos = LOAD 'data.csv' USING PigStorage(',')
    AS (
            id:int,
            nombre:chararray,
            apellido:chararray,
            f_nac:chararray,
            color:chararray,
            id2:int           
        ); 

filtro1 = FOREACH datos GENERATE SUBSTRING(f_nac,0,4) as anio;

filtro2 = GROUP filtro1 by anio; 

filtro3 = FOREACH filtro2 GENERATE group, COUNT(filtro1);

STORE filtro3 INTO 'output/' USING PigStorage(',');