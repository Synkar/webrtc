mkdir -p output
echo "docker run --rm -v ./output:/output ${1:-synkar_webrtc_build} /bin/bash -c 'tar -czvf /output/webrtc.tar.gz -C /opt webrtc'"
