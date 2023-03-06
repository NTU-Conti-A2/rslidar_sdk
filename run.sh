#! /bin/sh
docker run -it --rm \
        --network=host \
        -v /home/bumblebee/docker/rslidar_sdk:/home/user/catkin_ws/src/rslidar_sdk \
        rslidar_sdk:noetic /bin/zsh -c "roslaunch rslidar_sdk corriere_start.launch"