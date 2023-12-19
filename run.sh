#! /bin/sh
docker run -itd --rm \
        --network=host \
        --name new_rslidar_sdk_v2 \
        -v /home/bumblebee/docker/rslidar_sdk_v2:/home/user/catkin_ws/src/rslidar_sdk \
        rslidar_sdk_v2:noetic /bin/zsh -c "roslaunch rslidar_sdk corriere_start.launch"