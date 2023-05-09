FROM ros:noetic

COPY . /workspace/src/webrtc

# Install webrtc build dependencies
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 3 \
    && apt-get update \
    && if [ ! -f /etc/ros/rosdep/sources.list.d/20-default.list ]; then rosdep init; fi \
    && rosdep update --include-eol-distros --rosdistro $ROS_DISTRO \
    && rosdep install --default-yes --ignore-packages-from-source --from-paths "/workspace/src" \
    && rm -rf /var/lib/apt/lists/*

RUN /ros_entrypoint.sh catkin_make_isolated \
        --source /workspace/src \
        --install \
        --install-space /opt/webrtc

CMD ["bash"]
