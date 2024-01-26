---
title: About GraXpert
linkTitle: About
menu: {main: {weight: 10}}
---

{{% blocks/cover title="About GraXpert" image_anchor="bottom" height="auto" %}}
A fast and easy way to remove gradients
{.mt-5}

{{% /blocks/cover %}}


{{% blocks/lead color="primary" %}}

GraXpert is designed to remove gradients from astroimages.
As the name suggests, gradients are gradual changes in brightness that are not part of the astrophoto but are caused by external interference.
Causes can be, e.g., light pollution, incorrect or missing flat correction, but also natural brightness gradients of the night sky and peculiarities of the optics used (shading in the form of a vignette).

In order to edit deep-sky photos, it makes sense to remove such gradients from the images.
Not only does it look better, but also simplifies further processing of the image.
Color casts can also be removed in this way and it generally makes sense to free the astrophoto from the amount of the sky background.
In short: A gradient removal is very useful, if not mandatory.

GaXpert is freely available open source software that was programmed exclusively for this purpose.
It works stand alone, not as a plug-in for any other software.

{{% /blocks/lead %}}


{{% pageinfo color="warning" %}}
TODO: Update Screenshots to GraXpert 2.2.x
{{% /pageinfo %}}


{{% blocks/section color="gray 200" %}}

## Examples

Here are some examples that are processed with GraXpert

<div class="row">
<div class="col-sm">
Before Graxpert
{{% imgproc M65before-1536x825 Fill "512x275" %}}
{{% /imgproc %}}
</div>
<div class="col-sm">
After Graxpert
{{% imgproc M65after-1536x823 Fill "512x275" %}}
{{% /imgproc %}}
</div>
</div>
<div class="row">
<div class="col-sm">
{{% imgproc M42before-1536x826 Fill "512x275" %}}
{{% /imgproc %}}
</div>
<div class="col-sm">
{{% imgproc M42after-1536x825 Fill "512x275" %}}
{{% /imgproc %}}
</div>
</div>

{{% /blocks/section %}}



{{% blocks/section color="primary" %}}

## Videos

Here are some Tutorial Videos

<div class="row">
<div class="col-sm">
{{< youtube RVLvohS0qW0 >}}
</div>
<div class="col-sm">
{{< youtube AzDDafSrZ7k >}}
</div>
</div>

{{% /blocks/section %}}
