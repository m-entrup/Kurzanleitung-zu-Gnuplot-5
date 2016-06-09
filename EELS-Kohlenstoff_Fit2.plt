set encoding utf8

set title 'EEL Spektrum der Kohlenstoff K-Kante'
set xlabel 'Energieverlust [ln(eV)]'
set ylabel 'Intensität [a.u.]'
set key outside bottom center

set loadpath './config'
load 'xyborder.cfg'
load 'grid.cfg'

f(x) = b + m * x
g(x) = c + n * x

fit f(x) 'Daten/EELS-Spektrum_log.csv' yerror via b,m
fit [:5.645] g(x) 'Daten/EELS-Spektrum_log.csv' yerror via c,n

plot 'Daten/EELS-Spektrum_log.csv' title 'Messung 1' with yerrorbars, \
	f(x) title 'linearer Fit durch alle Datenpunkte', \
	g(x) title 'linearer Fit im linearen Bereich'
