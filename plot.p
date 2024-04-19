set terminal png size 600
set output "reporte.png"
set title "1000 peticiones, 300 peticiones concurrentes"
set size ratio 0.6
set grid y
set xlabel "Nro Peticiones"
set ylabel "Tiempo de respuesta (ms)"
plot "out.data" using 9 smooth sbezier with lines title "http://ip_servidor/cipher"