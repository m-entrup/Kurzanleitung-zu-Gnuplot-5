# EELS-Spektrum.msa

Dies ist der Ausgangsdatensatz. Es handelt sich um ein Energieverlustspektrum, welches mit einem Transmissions-Elektronen-Mikroskop (TEM) aufgenommen wurde. Bei der Probe handelt es sich um einen dünnen Kohlenstofffilm, weshalb das Spektrum die K-Kante (Anregung eines Elektrons aus der K-Schale) zeigt.

Die Datei enthält Meta-Daten. Diese werden von Gnuplot ignoriert, da die entsprechenden Zeilen mit einem Kommentar-Zeichen (#) beginnen. Die eigentlichen Daten sind der Energieverlust in eV (1. Spalte) und die vom CCD detektierte Intensität (2. Spalte). Die Intensität ist proportional zu Anzahl der Elektronen, welche auf den Szintillator (Elektronen erzeugen Licht) der Kamera treffen. Die Intensität lässt sich somit in eine Anzahl von Elektronen umrechnen. Mit Hilfe der Poisson-Statistik können wir aus der Anzahl der Elektronen auf die Messunsicherheit schließen.

## EELS-Spektrum_reduced.csv

Zuerst möchte ich die Daten bereinigen. Die Meta-Daten sind nicht relevant und sollen deshalb entfernt werden. Außerdem gibt es einen Messwert, der eine negative Intensität enthält. Dies tritt gelegentlich durch die Art der Datenerfassung auf und ist somit nicht physikalisch begründet. Diesen Messwert wollen wir deshalb herausfiltern. Außerdem wollen wir die Anzahl der Datenpunkte reduzieren. Besonders bei der Darstellung mit Fehlerbalken überlappen sich viele der 1024 Datenpunkte. Wir verwenden deshalb nur jeden fünften Wert.

```
# Gnuplot kann nicht nur Diagramme ausgeben. Im Table-Mode erzeugt Gnuplot Textdateien
# Wir verwenden vorerst eine tempräre Datei, die wir später noch verarbeiten.
set table 'temp.csv'

# Wir nutzen eine Funktion um Daten zu Filtern:
# Wenn ein Wert kleiner ist als 10, wird statt diesem 1/0 (nan) verwendet.
# Tritt die Bedingung nicht ein, dann wird der eigentliche Wert verwendet.
filter(n) = (n<0) ? 1/0 : n

# Wir plotten ganz normal, jedoch werden die Daten in eine Text-Datei geschrieben.
# Der Filter wird auf die Werte in der 2ten Spalte angewendet.
# Wir geben mit Hilfe von every nur jeden 5ten wert aus.
# Die anweisung 'with table' ist optional und sorgt dafür, dass keine unnötige 3te Spalte erzeugt wird.
plot 'EELS-Spektrum.msa' using 1:(filter($2)) every 5 with table

# Wir schalten wieder in den normalen Plot-Modus
unset table

# Mit dem ausführungszeichen führt man Shell-Kommandos aus.
# Da ich Gnuplot in der Bash (unter Linux) ausführe kann ich 'cat', 'grep' und 'rm' nutzen 

# Es werde nur die Zeilen in eine neue Datei geschrieben, die nicht 'nan' enthalten.
! cat temp.csv | grep --invert-match 'nan' > EELS-Spektrum_reduced.csv
# Die tempräre Datei löschen.
! rm temp.csv
```

## EELS-Spektrum_err.csv

In dieser Datei wurde die Intensität in eine Anzahl von registrierten Elektronen umgerechnet. Mit Hilfe des *Wurzel-N Gesetzes* der Poissonverteilung können wir die Standardabweichung und damit eine Unsicherheit berechnen.

```
set table 'EELS-Spektrum_err.csv'

# Die Werte für die Spalten 2 (Anzahl der Elektronen) und 3 (zugehörige Unsicherheit) errechnen wir aus den Werten in Spalte 2.
# Wir wählen als Unsicherheit die zweifache Standardabweichung, um etwa ein 95%-Konfidenzintervall zu erreichen.
plot 'EELS-Spektrum_reduced.csv' using 1:($2/7.44):(2*sqrt($2/7.44)) with table

unset table
```


## EELS-Spektrum_log.csv

Häufig möchte man eine lineare Abhängigkeit abbilden. Da der Untergrund beim EELS in Form einer Potenzfunktion verläuft, lässt sich durch logarithmische Darstellung der beiden Achsen eine linearer Verlauf erreichen. Diese Datei enthält schon die doppelt logarithmiertem Datenpunkte.

```
set table 'EELS-Spektrum_log.csv'

# Auf die ersten beiden Spalten wenden wir die Funktion 'log' an.
# Die Unsicherheit wird mit Hilfe von Fehlerfortpflanzung bestimmt.
plot 'EELS-Spektrum_err.csv' using (log($1)):(log($2)):($3/$2) with table

unset table
```
