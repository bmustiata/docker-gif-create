#!/usr/bin/env python
# -*- coding: utf-8 -*-

from gimpfu import *
import os

gettext.install("gimp20-python", gimp.locale_directory, unicode=True)


def make_animated_gif(folder, target_file, scaling):
    image = pdb.gimp_image_new(1, 1, 0)
    scaling = float(scaling)

    for image_path in sorted(map(lambda f: folder + '/' + f, os.listdir(folder))):
        layer = pdb.gimp_file_load_layer(image, image_path)
        pdb.gimp_image_add_layer(image, layer, 0)

    pdb.gimp_image_resize_to_layers(image)

    if scaling < 0.99:
        width = pdb.gimp_image_width(image)
        height = pdb.gimp_image_height(image)
        pdb.gimp_image_scale(image, width * scaling, height * scaling)

    pdb.gimp_image_convert_indexed(image, 0, 0, 255, 0, 0, 0)
    result = pdb.plug_in_animationoptimize(image, None)

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

