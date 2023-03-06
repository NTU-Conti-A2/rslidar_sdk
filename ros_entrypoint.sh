#!/bin/zsh
set -e

# setup ros environment
if [ -z "${SETUP}" ]; then
    # basic ros environment
    source "/opt/ros/$ROS_DISTRO/setup.zsh"
    source "/home/user/catkin_ws/devel/setup.zsh"
else
    #from environment variable; should be a absolute path to the appropriate workspaces's setup.bash
    source $SETUP
fi

exec "$@"