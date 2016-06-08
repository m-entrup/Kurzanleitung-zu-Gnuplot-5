# EELS-Spektrum.msa

Dies ist der Ausgangsdatensatz. Es handelt sich um ein Energieverlustspektrum, welches mit einem Transmissions-Elektronen-Mikroskop (TEM) aufgenommen wurde. Bei der Probe handelt es sich um einen dünnen Kohlenstofffilm, welhalb das Spektrum die K-Kante (Anregung eines Elektrons aus der K-Schale) zeigt.

Die Datei enthält Meta-Daten. Diese werden von Gnuplot ignoriert, da die entsprechenden Zeilen mit einem Kommentar-Zeichen (#) beginnen. Die eigentlichen Daten sind der Energieverlust in eV (1. Spalte) und die vom CCD detektierte Intensität (2. Spalte). Die Intensität ist proportional zu Anzahl der Elektronen, welche auf den Szintillator (Elektronen erzeugen Licht) der Kamera treffen. Die Intensität lässt sich somit in eine Anzahl von Elektronen umrechnen. Mit Hilfe der Poisson-Statistik können wir aus der Anzahl der Elektronen auf die Messunsicherheit schließen.
