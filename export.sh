version=$(cat package.xml | grep "<version>" | sed 's|\ *<\/*version>\ *||g')
mkdir -p output
docker run --rm -v ./output:/output ${1:-synkar_webrtc_build} /bin/bash -c "tar -czvf /output/webrtc-$version.tar.gz -C /opt webrtc"
