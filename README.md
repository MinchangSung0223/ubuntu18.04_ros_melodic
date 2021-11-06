# ros_18.04_azure_kinect_docker


참고 : http://docs.neuromeka.com/2.3.0/kr/ROS/section4a/


1. Docker 설치
```bash
curl https://get.docker.com | sh \
  && sudo systemctl --now enable docker
 
    sudo usermod -aG docker $USER # 현재 접속중인 사용자에게 권한주기
    sudo usermod -aG docker your-user # your-user 사용자에게 권한주기

distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update

sudo apt-get install -y nvidia-docker2
sudo reboot
```
2. 실행
```bash
bash build.sh
bash start.sh
roscore

```

```bash
bash multi_terminal.sh
roslaunch indy7_robotiq_moveit_config demo.launch
```


