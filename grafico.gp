set terminal png size 800,600
set output 'grafico.png'

set term png font "Helvetica,12"
set title 'Tiempo tomado en atender procentaje de solicitudes'
set xlabel 'Porcentaje de solicitudes servidas'
set ylabel 'Tiempo (ms)'
set grid
set key autotitle columnhead


# Configurar rangos de ejes
set xrange [0:100]
set yrange [0:*]
set datafile separator ","

# Trama de datos, omitiendo la primera fila (encabezado)
plot 'data.csv' every ::1 using 1:2 with lines title 'Datos'

set output