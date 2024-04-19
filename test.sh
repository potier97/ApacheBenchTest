#!/bin/bash

# Número total de iteraciones
total_iterations=2

# Cantidad inicial de solicitudes concurrentes
concurrency=100
increment=200

# Cantidad total de solicitudes a enviar en cada iteración
total_requests=10000

# Url de la api a testear
api_url="http://localhost:5000/cipher"

# Directorio base para guardar los archivos de salida
base_dir="experiment_results"

#Crear directorio para guardar los resultados
mkdir -p $base_dir

# Delay entre iteraciones
iteration_delay=1

# Ejecutar las iteraciones
max=10
for i in `seq 1 $total_iterations`; do
    # Calcular la cantidad de solicitudes concurrentes para esta iteración
    echo "Iteración $i: $concurrency solicitudes concurrentes"

    # Crear un directorio para esta iteración
    iteration_dir="$base_dir/iteration_$i"
    mkdir -p $iteration_dir

    # Archivos para guardar los resultados
    data_csv="$iteration_dir/data.csv"
    output_csv="$iteration_dir/output.csv"
    result_txt="$iteration_dir/result.txt"
    graph_png="$iteration_dir/porcentaje.png"
    report_png="$iteration_dir/reporte.png"
    
    # Ejecutar ApacheBench con los parámetros especificados
    ab -n $total_requests -c $concurrency -p data-cifrar.json -T application/json -rk -e $data_csv -g $output_csv $api_url > $result_txt
    concurrency=$((concurrency + increment))
    sleep 1

    # Generar gráfico con Gnuplot
    gnuplot << EOF
    set terminal png size 800,600
    set output "$report_png"
    set term png font "Helvetica,12"
    set title "$total_requests peticiones, $concurrency peticiones concurrentes"
    set size ratio 0.6
    set xlabel "Nro Peticiones"
    set ylabel "Tiempo de respuesta (ms)"
    set grid
    plot '$output_csv' using 9 smooth sbezier with lines title '$api_url'
EOF

#     # Grafico de porcentaje de solicitudes servidas vs tiempo de respuesta
    gnuplot << EOF
    set terminal png size 800,600
    set output "$graph_png"
    set term png font "Helvetica,12"
    set title "$total_requests peticiones: Tiempo de respuesta en función del porcentaje de solicitudes servidas"
    set xlabel "Porcentaje de solicitudes servidas"
    set ylabel "Tiempo de respuesta (ms)"
    set xrange [0:100]
    set yrange [0:*]
    set grid
    set datafile separator ","
    plot '$data_csv' every ::1 using 1:2 with lines title 'Tiempo de respuesta'
EOF


   

     # Esperar antes de la siguiente iteración
    echo "Esperando $iteration_delay segundos antes de la siguiente iteración..."
    sleep $iteration_delay
done
