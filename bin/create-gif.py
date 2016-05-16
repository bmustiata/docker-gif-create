#!/usr/bin/env python
# -*- coding: utf-8 -*-

from gimpfu import *
import os

gettext.install("gimp20-python", gimp.locale_directory, unicode=True)


def make_animated_gif(folder, target_file, scaling):
    image = pdb.gimp_image_new(1, 1, 0)
    # Uncomment if not running headless
    # pdb.gimp_display_new(image)

    scaling = float(scaling)

    print("Scaling: %f", scaling)

    images = list(sorted(map(lambda f: folder + '/' + f, os.listdir(folder))))
    for i in range(len(images)):
        image_path = images[i]
        print("Processing image %d from %d" % (i, len(images)))
        layer = pdb.gimp_file_load_layer(image, image_path)

        pdb.gimp_image_add_layer(image, layer, 0)

        # The layer needs first added to the image, and only then scaled.
        if scaling < 0.99:
            width = pdb.gimp_drawable_width(layer)
            height = pdb.gimp_drawable_height(layer)
            pdb.gimp_layer_scale(layer, width * scaling, height * scaling, False)

    print("Resize image")
    pdb.gimp_image_resize_to_layers(image)

    print("Coverting to indexed image.")
    pdb.gimp_image_convert_indexed(image, 0, 0, 255, 0, 0, 0)

    print("Optimizing animation.")
    result = pdb.plug_in_animationoptimize(image, None)

    print("Saving")
    pdb.file_gif_save(result, None, target_file, target_file, 0, 1, 10, 0)


register(
    "python-fu-create-gif",
    N_("Create an animated GIF from a folder full of pngs."),
    "make_animated_gif (folder, target_file, scaling=1) -> void",
    "Bogdan Mustiata <bogdan.mustiata@gmail.com>",
    "(c) Bogdan Mustiata <bogdan.mustiata@gmail.com>",
    "2016",
    N_("_Create GIF From Folder..."),
    "",
    [
     (PF_DIRNAME, "folder", _("Folder"), ""),
     (PF_STRING,  "target_file",  _("Name of the File"), "/tmp/output.gif"),
     (PF_STRING,  "scaling",  _("Scaling"), "1"),
    ],
    [],
    make_animated_gif,
    menu="<Image>",
    domain=("gimp20-python", gimp.locale_directory)
    )

main()
