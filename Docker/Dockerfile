# This is an auto generated Dockerfile for ros:ros-base
# generated from docker_images_ros2/create_ros_image.Dockerfile.em
FROM ros:jazzy-ros-core-noble

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    build-essential \
    git \
    python3-colcon-common-extensions \
    python3-colcon-mixin \
    python3-rosdep \
    python3-vcstool \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init && \
  rosdep update --rosdistro $ROS_DISTRO
  

# setup colcon mixin and metadata
RUN colcon mixin add default \
      https://raw.githubusercontent.com/colcon/colcon-mixin-repository/master/index.yaml && \
    colcon mixin update && \
    colcon metadata add default \
      https://raw.githubusercontent.com/colcon/colcon-metadata-repository/master/index.yaml && \
    colcon metadata update

# install ros2 packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-jazzy-ros-base=0.11.0-1* \
    && rm -rf /var/lib/apt/lists/*

# install dependencies for building rosbridge_suite
RUN apt update && \ 
    rosdep install --from-paths /opt/ros/$ROS_DISTRO/share --ignore-src -y --skip-keys "cyclonedds fastcdr fastrtps iceoryx_binding_c rmw_connextdds rti-connext-dds-6.0.1 urdfdom_headers"

# Copy setup script into the container
COPY setup.bash /tmp/setup.bash

# Append the command to source the script to the .bashrc file
RUN echo "source /tmp/setup.bash" >> /root/.bashrc

# Install rosbridge server
RUN mkdir -p ~/ros_ws/src && \
    cd ~/ros_ws/src && \
    git clone -b $ROS_DISTRO https://github.com/Georz1/rosbridge_suite.git && \
    cd ~/ros_ws && \
    . "/opt/ros/$ROS_DISTRO/setup.sh" && \
    rosdep install -i --from-path src --rosdistro $ROS_DISTRO -y && \
    colcon build --symlink-install

# Launch rosbridge server with bson_only_mode set to True
CMD . ~/ros_ws/install/local_setup.sh && \ 
  ros2 launch rosbridge_server rosbridge_websocket_launch.xml bson_only_mode:='True' url_path:='/ws'