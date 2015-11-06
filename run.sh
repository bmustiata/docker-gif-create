
docker run \
    --rm \
    -v $1:/tmp/in/test.avi \
    -v $(dirname $2):/tmp/write \
    -e OUTPUT_FILE_NAME=$(basename $2) \
    bmst/gif-create

