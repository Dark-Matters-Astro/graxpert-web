---
title: Algorithms
weight: 10
---

{{% pageinfo color="warning" %}}
Translation Needed
{{% /pageinfo %}}


## Berechnung des Hintergrundes

Der Hintergrundwert eines Samplepunktes wird mittels der [sigma\_clipped\_stats(cenfunc='median', stdfunc='std', grow=4)](https://docs.astropy.org/en/stable/api/astropy.stats.sigma_clipped_stats.html) Funktion des Astropy Packages berechnet. 
Hierbei werden zunächst alle Pixel im Samplepunkt aussortiert, deren Wert mehr als 3 Standardabweichungen vom Median entfernt ist. 
Diese Ausreißer können z.B. durch Sterne im Samplepunkt verursacht werden. 
Um die Ausreißer herum werden zusätzlich alle Pixel entfernt, die einen Abstand von weniger als 4 Pixel besitzen. 
Dieser Vorgang wird so lange wiederholt, bis es keine Ausreißer mehr gibt. 
Der Hintergrundwert wird dann bestimmt durch den Median der übrig gebliebenen Werte.

## Berechnung des Hintergrundmodells

Die Berechnung des Hintergrundmodells (für einen Farbkanal) lässt sich mathematisch beschreiben durch die Suche nach einer Funktion \\(f: \mathbb{R}^2 \to \mathbb{R}\\), welche eine Bildkoordinate \\( \bm{x}=(x_1,x_2) \\) auf die Hintergrundhelligkeit abbildet.
Als Stützstellen für diese Funktion dienen die Samplepunkte \\((\bm{x}_i,y_i)\\), wobei \\(\bm{x}_i \\) die Mittelpunktskoordinate des i-ten Samplepunktes ist und \\(y_i\\) der berechnete Hintergrundwert für diesen Samplepunkt. 
Für die Funktion \\(f\\) soll also gelten, dass \\(f(\bm{x}_i) = y_i\\).
Zwischen den Samplepunkten soll die Funktion \\(f\\) stetig und möglichst glatt verlaufen.
Dieses Problem der Findung einer geeigneten Funktion \\(f\\) nennt man Interpolation. 
Im Folgenden werden die verschiedenen in GraXpert verfügbaren Interpolationsverfahren vorgestellt.

### Splines

Bei der Spline-Interpolation wird das Hintergrundmodell stückweise durch Polynome zwischen den Stützstellen approximiert.
Hierbei wird die [interpolate.bisplrep()](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.bisplrep.html) Funktion des Scipy Packages verwendet.

### Radiale Basisfunktionen (RBF)

Radiale Basisfunktionen sind Funktionen der Form \\(\phi(\bm{x}) = \phi(\|| \bm{x} ||)\\), wobei wir in unserem Fall die euklidische Norm \\(\|| \bm{x} || = \sqrt{x_1^2 + x_2^2}\\) verwenden.
Die Funktion \\(f\\) kann nun als Linearkombination
```math
\begin{equation}
f(\bm{x}) = \sum_i w_i \, \phi(||\bm{x} - \bm{x_i}||) + o
\end{equation}
```
aufgebaut werden, wobei \\(w_i\\) den Gewichten für die verschiedenen Samplepunkte und \\(o\\) einem konstanten Offset entspricht.

Aus der Forderung, dass die Funktion \\(f\\) die Samplepunkte durchlaufen soll, ergibt sich die Bedingung
```math
\begin{equation}
\begin{pmatrix}
\phi(\bm{x}_1 - \bm{x}_1) & \phi(\bm{x}_1 - \bm{x}_2) & \dots & \phi(\bm{x}_1 - \bm{x}_N) & 1 \\
\phi(\bm{x}_2 - \bm{x}_1) & \phi(\bm{x}_2 - \bm{x}_2) & \dots & \phi(\bm{x}_2 - \bm{x}_N) & 1 \\
\vdots & \vdots & \ddots & \vdots \\
\phi(\bm{x}_N - \bm{x}_1) & \phi(\bm{x}_N - \bm{x}_2) & \dots & \phi(\bm{x}_N - \bm{x}_N) & 1 \\
1 & 1 & \dots & 1 & 0
\end{pmatrix}
\begin{pmatrix}
w_1 \\ w_2 \\ \vdots \\ w_N \\ o
\end{pmatrix}
=
\begin{pmatrix}
y_1 \\ y_2 \\ \vdots \\ y_N \\ 0
\end{pmatrix} \, ,
\end{equation}
```
welche nur dann erfüllbar ist, wenn die Matrix auf der linken Seite invertierbar ist. 
Mit der richtigen Wahl der Funktion \\(\phi\\) kann dies immer gewährleistet werden~\cite{wright2003radial}. 
Zusätzlich haben wir hier gefordert, dass \\(\sum_i o \, w_i = 0\\).

Zusätzlich wird zu der Matrix auf der linken Seite der Summand \\(s \, I\\) addiert, wobei \\(s\\) ein Smoothingparameter ist und \\(I\\) die Einheitsmatrix.

Das Gleichungssystem (2) wird mittels der Funktion [linalg.solve()](https://docs.scipy.org/doc/scipy/reference/generated/scipy.linalg.solve.html) des Scipy Packages gelöst.

Für die radiale Basisfunktion \\(\phi\\) gibt es die folgenden Optionen:
* Thin-plate spline: \\(\phi(|\bm{x}|) = |\bm{x}|^2 \log(|\bm{x}|)\\)
* linear: \\(\phi(|\bm{x}|) = |\bm{x}|\\)
* cubic: \\(\phi(|\bm{x}|) = |\bm{x}|^3\\)
* quintic: \\(\phi(|\bm{x}|) = |\bm{x}|^5\\)

### Kriging

Das Kriging, oder auch Gaußprozess-Regression genannt, ist ein Interpolationsverfahren aus der Geostatistik.
Anders als bei den beiden vorher genannten Interpolationsverfahren wird hier kein Smoothing angewandt und der Smoothingparameter hat somit keine Auswirkungen auf das Ergebnis.
Für das Kriging wird die [OrdinaryKriging(variogram\_model='spherical')](https://geostat-framework.readthedocs.io/projects/pykrige/en/stable/generated/pykrige.ok.OrdinaryKriging.html)-Klasse des Pykrige Packages verwendet.

## Berechnung des fertigen Bildes

Falls in den erweiterten Einstellung 'Subtraction' als Korrektur ausgewählt ist, wird der Farbkanal \\(c\\) des fertigen Bilds nach der Ermittlung des Hintergrundmodells berechnet durch

```math
\begin{equation}
\mathrm{Fertiges  \, Bild}[c] = \mathrm{Originalbild}[c] - \mathrm{Hintergrundmodell}[c] + \mathrm{Mittelwert(Hintergrundmodell)} \, ,
\end{equation}
```

wobei der Mittelwert des Hintergrundmodells über alle Farbkanäle bestimmt wird.

Bei Auswahl der Option 'Division' für die Korrektur, berechnet sich das fertige Bild durch

```math
\begin{equation}
\mathrm{Fertiges \, Bild}[c] = \mathrm{Originalbild}[c] \, / \, \mathrm{Hintergrundmodell}[c] \times \mathrm{Mittelwert(Hintergrundmodell)}[c] \, ,
\end{equation}
```

wobei der Mittelwert des Hintergrundmodells separat für die einzelnen Farbkanäle bestimmt wird.