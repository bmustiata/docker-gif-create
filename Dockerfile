FROM ubuntu:14.04
MAINTAINER Bogdan Mustiata <bogdan.mustiata@gmail.com>

RUN apt-get update -y && apt-get upgrade -y

RUN useradd -m raptor

ENV UID=1000
ENV GID=1000

CMD perl -pi -e "s/raptor:x:1000:1000/raptor:x:$UID:$GID/" /etc/passwd && \
    perl -pi -e "s/raptor:x:1000:/raptor:x:$GID:/" /etc/group

RUN apt-get install -y\
    libav-tools \
    imagemagick \
    gifsicle

USER raptor

ENV INPUT_FILE=/tmp/in/test.avi
ENV OUTPUT_FILE=/tmp/out/test.gif

#
# The name of the file name that will be saved in the writing
# folder.
#
ENV WRITE_FOLDER=/tmp/write
ENV OUTPUT_FILE_NAME=test.gif

ADD bin /home/raptor/bin

CMD /home/raptor/bin/run_conversion.sh $OUTPUT_FILE_NAME
