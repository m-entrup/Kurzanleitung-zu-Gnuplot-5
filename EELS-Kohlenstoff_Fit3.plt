set encoding utf8

set title 'EEL Spektrum der Kohlenstoff K-Kante'
set xlabel 'Energieverlust [eV]'
set ylabel 'Intensität [a.u.]'
set key outside bottom center

set loadpath './config'
load 'xyborder.cfg'
load 'grid.cfg'

f(x) = 1e9 * a * x**-r
g(x) = b + m * x

fit [:283] f(x) 'Daten/EELS-Spektrum_err.csv' yerror via a,r
fit [:283] g(x) 'Daten/EELS-Spektrum_err.csv' yerror via b,m

plot 'Daten/EELS-Spektrum_err.csv' title 'Messung 1' with yerrorbars, \
	f(x) title 'Fit einer Potenzfunktion', \
	g(x) title 'Fit lineareren Funktion'
