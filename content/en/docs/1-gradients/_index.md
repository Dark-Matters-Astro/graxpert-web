---
title: What are Gradients?
weight: 1
---

{{% pageinfo color="warning" %}}
Translation Needed
{{% /pageinfo %}}


Gradienten sind, wie der Name schon sagt, graduelle Helligkeitsverläufe die nicht zum Astrofoto dazu gehören, sondern durch äußere Störeinflüsse entstanden sind. Ursachen können z.B. Lichtverschmutzung oder eine falsche bzw. fehlende Flatkorrektur sein, aber auch natürliche Helligkeitsverläufe des Nachthimmels, sowie Eigenarten der verwendeten Optik (Abschattung in Form einer Vignette). Um Deep-Sky Fotos zu bearbeiten ist es sinnvoll solche Gradienten aus den Bildern zu entfernen. Das schaut nicht nur besser aus, sondern vereinfacht auch die weitere Bearbeitung des Bildes. Auch Farbstiche lassen sich auf diese Art und Weise entfernen und generell ist es sinnvoll das Astrofoto vom Betrag des Himmelshintergrundes zu befreien.

Kurzum: Eine Gradienten Entfernung ist sehr sinnvoll, beinahe zwingend notwendig. Verschiedene kostenpflichtige Astrosoftwares bieten sehr gute Werkzeuge zur Gradienten Entfernung wie etwa PixInsight (DBE,ABE) oder AstroPixelProcessor. Auch kann man kostenpflichtige PlugIns für die Softwares AdobePhotoshop oder Affinity Photo erwerben um das Problem zu lösen. GraXpert ist eine frei erhältliche Open Source Software, die ausschließlich für diese Zwecke programmiert wurde. Sie funktioniert Stand Alone, also nicht als PlugIn für irgendeine andere Software.

{{< cardpane >}}
  {{< card >}}
    {{% imgproc M81_mit_gradient.jpg Fill "473x314" %}}
    {{% /imgproc %}}
    Im Bild ist ein deutlicher Farbgradient zu erkennen. Der untere Teil des Bildes weist einen roten Farbton auf, während der obere Teil grünlich gefärbt ist.
  {{< /card >}}
  {{< card >}}
    {{% imgproc M81_ohne_gradient.jpg Fill "473x314" %}}
    {{% /imgproc %}}
    Im Bild ist der Gradient nach Anwendung von GraXpert vollständig entfernt.
  {{< /card >}}
{{< /cardpane >}}




