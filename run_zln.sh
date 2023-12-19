#! /bin/sh
docker run -itd --rm \
        --network=host \
        --name new_rslidar_sdk_v2 \
        -v /home/zln/Conti/rsidar_sdk_v2:/home/user/catkin_ws/src/rslidar_sdk \
        rslidar_sdk_v2:noetic