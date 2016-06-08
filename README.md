# Kurzanleitung-zu-Gnuplot-5
Eine kurze Einführung in die Verwendung von Gnuplot 5 für Physiker.

## Gnuplot installieren und starten

### Linux

Gnuplot ist eine OpenSource Software und sollte deshalb in den Paketquellen aller Linux-Distributionen vorhanden sein. Bei Debian 8 genügt z.B. das Ausführen von ``sudo apt install gnuplot5``, um Gnuplot 5 zu installieren. Gibt man ``gnuplot`` statt ``gnuplot5`` an, erhält man noch die alte Version 4.6.6. Anschließend kann man in der Bash ``gnuplot5`` aufrufen, um das Programm auszuführen.

### Windows

Alle Bisher veröffentlichten Versionen gibt es bei [sourceforge als Download][download]. Man muss nur die passende Version wählen (32bit oder 64bit, sowie Installer oder ZIP-Archiv) und diese installieren/entpacken. Enthalten ist die ausführbare Datei *wgnuplot.exe* (im Ordner *bin*), mit der man die Textkonsole von Gnuplot startet.

## Die Daten begutachten

Diese Kurzanleitung verwendet die Beispieldateien aus dem Ordner *Daten*. Dort ist eine README-Datei zu finden, die erläutert, wie die unterschiedlichen csv-Dateien erzeugt wurden.

Zuerst möchte ich den Datensatz *EELS-Spektrum.msa* begutachten. Dazu führe ich

```
# Dies ist ein Kommentar.
# Der Dateiname muss von Anführungszeichen umschlossen sein (egal ob einfache oder doppelte).
plot 'EELS-Spektrum.msa'
```

aus, wodurch sich ein neues Fenster öffnen sollte, welches folgendes Diagramm zeigt:

![Diagramm von EELS-Spektrum.msa](Bilder/EELS-Spektrum.msa.png)

Es ist gut zu sehen, dass sich die 1024 Datenpunkte überlappen. Im Folgenden möchte ich deshalb mit dem Datensatz *EELS-Spektrum_reduced.csv* arbeiten, der nur jeden fünften Datenpunkt enthält.

```
plot 'EELS-Spektrum_reduced.csv'
```

![Diagramm von EELS-Spektrum_reduced.csv](Bilder/EELS-Spektrum_reduced.csv.png)

Tipp:
	Normalerweise zeigt Gnuplot keine Gitterlinien an. Diese kann man jedoch über den entsprechenden Button in der grafischen Oberfläche aktivieren, oder man führt den Befehl ``set grid`` aus.

## Das Diagramm verbessern

Die bisher erstellten Diagramme sind nicht besonders informativ. Es gibt weder einen Titel, noch sind die Achsen beschriftet. Außerdem zeigt die schlecht platzierte Legende nur den Namen der verwendeten Datei an. Wie es besser geht, dass zeigt [EELS-Kohlenstoff1.plt]. Alle zum Plotten notwendigen Befehle sind in einer Datei zusammengefasst und lassen sich mit ``load 'EELS-Kohlenstoff1.plt'`` in Gnuplot ausführen. Hat man Gnuplot noch nicht gestartet, dann kann man alternativ ``gnuplot5 -p EELS-Kohlenstoff1.plt`` in der Bash ausführen. der Parameter ``-p`` ist notwendig, damit das Diagramm auch angezeigt wird. Schreibt man in eine Datei (siehe Unten), kann man ``-p`` auch weglassen.

```
# Ermöglicht die direkte Eingabe diverser Sonderzeichen.
set encoding utf8

# Titel und Label werden in Anführungszeichen hinter den jeweiligen Befehlen angegeben.
set title 'EEL Spektrum der Kohlenstoff K-Kante'
set xlabel 'Energieverlust [eV]'
set ylabel 'Intensität [a.u.]'

# Die Legende heißt bei Gnuplot key. Mögliche Optionen sind inside|outside, left|right|center und top|bottom|center (weitere: siehe Anleitung).
set key inside left top

# Es ist sehr praktisch Vorlagen zu verwenden. Auf [gnuplotting.org] wird deren Verwendung detailliert erklärt.
# Gibt an, welches Verzeichnis für 'load' benutzt wird.
set loadpath './config'
# Stellt die Achsen weniger in den Vordergrund, damit die eigentlich Daten mehr Aufmerksamkeit erhalten.
load 'xyborder.cfg'
# Verbessert die Darstellung der Gitterlinien.
load 'grid.cfg'

# An 'plot' wird der zusätzliche Parameter 'title' übergeben. Auf diesen muss ein String folgen, der den Datensatz beschreibt.
# Da sich die Datei 'EELS-Spektrum_reduced.csv' in einem Unterordner (Daten) befindet, müssen wird diesen mit angeben.
plot 'Daten/EELS-Spektrum_reduced.csv' title 'Messung 1'
```

![Verbessertes Diagramm von EELS-Spektrum_reduced.csv](Bilder/EELS-Spektrum_reduced.csv.2.png)

[download]: https://sourceforge.net/projects/gnuplot/files/gnuplot/
[gnuplotting.org]: http://www.gnuplotting.org/?p=1994
