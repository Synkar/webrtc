ARG ROS_TAG=noetic

FROM ros:$ROS_TAG

# The default shell during build is not bash
# Needed to allow later build steps to source the workspace
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV SYNKAR_WS=/root/synkar_ws

# Install webrtc build dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        git \
        wget \
        cmake \
        libgtk2.0-dev \
        libgtk-3-dev \
        libglib2.0-dev \
        libasound2-dev \
        libpulse-dev \
        libjpeg-dev \
        python3-pip \
        python3-httplib2 \
    && rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 3

# Webrtc install dir
RUN mkdir -p /tmp/webrtc_install

COPY . workspace/src

CMD ["bash"]
