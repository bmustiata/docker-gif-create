bmst/gif-create
===============

A docker image to convert a movie to a gif, to present things:

![Sample Output](doc/demo.gif)

Running
-------

```shell
docker run \
    --rm \
    -v /path/to/your/input/file.avi:/tmp/in/test.avi \
    -v /some/writable/folder:/tmp/write \
    -e OUTPUT_FILE_NAME=output.gif \
    bmst/gif-create
```

After chewing a bunch of data, you will get the result as: `/some/writable/folder/output.gif`

Or you can write a [shell script](run.sh):

```shell
docker run \
    --rm \
    -v $1:/tmp/in/test.avi \
    -v $(dirname $2):/tmp/write \
    -e OUTPUT_FILE_NAME=$(basename $2) \
    bmst/gif-create
```

And then run it as:

```shell
run.sh /path/to/your/input/file.avi /somw/writable/folder/output.gif
```

Thanks
------

Inspired from:
 * https://github.com/fgrehm/dotfiles/blob/master/bin/create-gif
 * https://eyeofmidas.wordpress.com/2014/06/03/how-to-record-desktop-images-into-gif-format-on-ubuntu-14-04/


