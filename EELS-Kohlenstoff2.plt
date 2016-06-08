set encoding utf8

set title 'EEL Spektrum der Kohlenstoff K-Kante'
set xlabel 'Energieverlust [eV]'
set ylabel 'Intensität [a.u.]'
set key inside top left

set loadpath './config'
load 'xyborder.cfg'
load 'grid.cfg'

set terminal png enhanced size 800,600 font ',16'
set output 'EELS-Spektrum_reduced.png'

plot 'Daten/EELS-Spektrum_reduced.csv' title 'Messung 1'

unset output
unset terminal
