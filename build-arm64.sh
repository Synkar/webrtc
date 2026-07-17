#!/bin/bash
# Build the webrtc arm64 deb inside an arm64 container (qemu binfmt on x86 hosts).
# Downloads (depot_tools, webrtc source) persist in ./build/ on the host, so
# interrupted builds resume cheaply. Output: ./output/webrtc_<version>_arm64.deb
set -e

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")

build_image="webrtc_build_arm64"
if ! docker image inspect $build_image >/dev/null 2>&1; then
  echo "Using default ros:noetic-ros-base image"
  build_image="ros:noetic-ros-base"
fi

docker rm -f webrtc_build_arm64 2>/dev/null || true

set +e
docker run \
  --name webrtc_build_arm64 \
  --platform linux/arm64 \
  -v "$SCRIPT_DIR:/workspace" \
  --workdir /workspace \
  $build_image \
  /bin/bash -c "/workspace/build/ros_build /workspace"
status=$?

# Cache apt/rosdep layers for reruns, even on failure
docker commit webrtc_build_arm64 webrtc_build_arm64
docker rm webrtc_build_arm64
exit $status
