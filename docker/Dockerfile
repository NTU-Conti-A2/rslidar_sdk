FROM ros:noetic-perception
ARG DEBIAN_FRONTEND=noninteractive

# Change accordingly to your host account $UID and $GID (to enable consistent permission for bind mount for host and container)
ARG uid=1000
ARG gid=1000
ARG user_name=user

# Install basic apt packages
RUN apt update && apt upgrade -y && \
    apt install -y sudo vim wget curl zsh git python3-pip python3-rosdep python3-catkin-tools \
    # Dependencies by rs_driver
    libpcap-dev libeigen3-dev libboost-dev libpcl-dev && \
    apt autoremove -y && apt clean -y

# Create user account
RUN groupadd --gid ${uid} ${user_name} && \
    useradd --uid ${gid} --gid ${user_name} --groups sudo --create-home user --shell /bin/zsh && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 

# Switch to user
# USER ${uid}:${gid}

# Install oh-my-zsh
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.2/zsh-in-docker.sh)" -- \
    -t ys \
    -p git \
	-p z \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p https://github.com/zsh-users/zsh-syntax-highlighting

SHELL ["/bin/zsh", "-c"]

# Install rslidar_sdk
RUN mkdir -p /home/user/catkin_ws/src && cd /home/user/catkin_ws/src 
    #git clone https://github.com/RoboSense-LiDAR/rslidar_sdk.git && \
    #cd rslidar_sdk && git submodule init && git submodule update

COPY . /home/user/catkin_ws/src/rslidar_sdk

RUN . /opt/ros/$ROS_DISTRO/setup.zsh && \
    cd /home/user/catkin_ws && catkin init && rosdep update && rosdep install --from-paths src --ignore-src -r -y && \
    catkin build

RUN rm -rf /home/user/catkin_ws/src/rslidar_sdk && \
    sudo echo "source /opt/ros/$ROS_DISTRO/setup.zsh" >> ~/.zshrc && sudo echo "source /home/user/catkin_ws/devel/setup.zsh" >> ~/.zshrc && \
    sudo echo "source /opt/ros/$ROS_DISTRO/setup.bash" >> ~/.bashrc && sudo echo "source /home/user/catkin_ws/devel/setup.bash" >> ~/.bashrc && \
    sudo apt clean -y

COPY ros_entrypoint.sh /

ENTRYPOINT ["/ros_entrypoint.sh"]

CMD ["/bin/zsh"]
