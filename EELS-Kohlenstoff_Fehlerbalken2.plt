set encoding utf8

set title 'EEL Spektrum der Kohlenstoff K-Kante'
set xlabel 'Energieverlust [eV]'
set ylabel 'Anzahl der Elektronen'
set key inside top left

set loadpath './config'
load 'xyborder.cfg'
load 'grid.cfg'

plot 'Daten/EELS-Spektrum_err.csv' using 1:2:(0.7):3 with xyerrorbars title 'Messung 1 mit Fehlerbalken'
