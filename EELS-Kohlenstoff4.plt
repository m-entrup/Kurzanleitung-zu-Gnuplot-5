set encoding utf8

set title 'EEL Spektrum der Kohlenstoff K-Kante'
set xlabel 'Energieverlust [eV]'
set ylabel 'Intensität [a.u.]'
set key inside top left

set loadpath './config'
load 'xyborder.cfg'
load 'grid.cfg'

set logscale x
set logscale y

set xrange [220:340]

plot 'Daten/EELS-Spektrum_reduced.csv' title 'Messung 1'
