FROM nvidia/cuda:11.0-devel-ubuntu18.04
MAINTAINER Minchang Sung <tjdalsckd@gmail.com>
RUN apt-get update &&  apt-get install -y -qq --no-install-recommends \
    libgl1 \
    libxext6 \ 
    libx11-6 \
   && rm -rf /var/lib/apt/lists/*

ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES graphics,utility,compute


RUN echo 'export PATH=/usr/local/cuda-11.0/bin${PATH:+:${PATH}}' >> ~/.bashrc
RUN echo 'export LD_LIBRARY_PATH=/usr/local/cuda-11.0/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
RUN echo 'export PATH=/usr/local/cuda/bin:/$PATH' >> ~/.bashrc
RUN echo 'export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' >> ~/.bashrc
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y wget
RUN apt-get install -y sudo curl
RUN su root
RUN apt-get install -y python
RUN apt-get update && apt-get install -y lsb-release && apt-get clean all




ARG ssh_prv_key
ARG ssh_pub_key
RUN  apt-get -yq update && \
     apt-get -yqq install ssh
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan github.com > /root/.ssh/known_hosts
RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub
ENV DEBIAN_FRONTEND=noninteractive 

RUN   /bin/bash -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' 
RUN  apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654 
RUN  apt -y update 
RUN  apt -y upgrade 
ENV TZ=Europe/Minsk
ARG DEBIAN_FRONTEND=noninteractive  
ENV DEBIAN_FRONTEND=noninteractive  

RUN  DEBIAN_FRONTEND=noninteractive  ; TZ=Europe/Minsk;apt-get install -yq --no-install-recommends ros-melodic-desktop-full 
RUN  apt-get install -y python-pip 

RUN apt install -y  --no-install-recommends python-rosdep python-rosinstall python-rosinstall-generator python-wstool build-essential
RUN  pip install -U rosdep 
RUN  rosdep init 
RUN  rosdep update 
RUN echo "source /opt/ros/melodic/setup.bash" >> ~/.bashrc ;
RUN echo "source ~/catkin_ws/devel/setup.bash" >>~/.bashrc;

RUN cd ~ ;
RUN mkdir -p /root/catkin_ws/src;
RUN cd /root/catkin_ws;
RUN /bin/bash -c 'source /opt/ros/melodic/setup.bash; mkdir -p ~/catkin_ws/src; cd ~/catkin_ws; catkin_make'
RUN apt-get install git
RUN  apt-get install -y  ros-melodic-moveit \
                       ros-melodic-industrial-core \
                       ros-melodic-moveit-visual-tools \
                       ros-melodic-joint-state-publisher-gui

RUN  apt-get install -y ros-melodic-gazebo-ros-pkgs \
                       ros-melodic-gazebo-ros-control \
                       ros-melodic-joint-state-controller \
                       ros-melodic-effort-controllers \
                       ros-melodic-position-controllers \
                       ros-melodic-joint-trajectory-controller
RUN /bin/bash -c "cd ~/catkin_ws/src && git clone -b release-2.3 https://github.com/neuromeka-robotics/indy-ros"
RUN /bin/bash -c "cd ~/catkin_ws/src && git clone https://github.com/neuromeka-robotics/indy-ros-examples"
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash;cd ~/catkin_ws; catkin_make"
EXPOSE 80
EXPOSE 443




