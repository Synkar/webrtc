docker build -t synkar_webrtc_build .
SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
docker run --rm --name webrtc_build -v $SCRIPT_DIR:/source --network host -it synkar_webrtc_build /bin/bash -c 'cd /workspace && /ros_entrypoint.sh catkin_make_isolated --install --install-space /tmp/webrtc_install && tar -czvf /source/webrtc.tar.gz /tmp/webrtc_install'
