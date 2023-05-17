#!/bin/bash

# Select build image
build_image="webrtc_build"
docker image inspect $build_image >/dev/null 2>&1
if [ $? -ne 0 ]; then
  # If no previous build image is available, use ROS image
  echo "Using default ros:noetic-ros-base image"
  build_image="ros:noetic-ros-base"
fi

# Run the build
docker run -it \
  --name webrtc_build \
  -v .:/source \
  --workdir /workspace \
  $build_image \
  /bin/bash -c "/source/build/ros_build /workspace /opt"

# Save image to reuse on later builds
docker commit webrtc_build webrtc_build
docker rm webrtc_build

# Clean build image
read -n1 -p "Clean build? [y,n] " yn
echo ""
case $yn in
  y|Y) docker rmi webrtc_build ;;
esac
