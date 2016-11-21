Keras LSTM example [code](https://github.com/fchollet/keras/blob/master/examples/lstm_text_generation.py) with docker build.

 1. You can clone and build this yourself or you can use aocenas/keras-rnn:gpu

 2. run docker machine on amazon
 ```
 docker-machine create --driver amazonec2 --amazonec2-region eu-west-1 --amazonec2-zone c --amazonec2-vpc-id vpc-*** --amazonec2-instance-type g2.2xlarge aws-01
 ```
 It seems you need a VPC for this. If you cannot connect, see
 http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/TroubleshootingInstancesConnecting.html#TroubleshootingInstancesConnectionTimeout.
 You can use 'g' or 'p' series as both have GPU (p series are probably quicker for this), but it is possible you cannot
 create such instances and you will have to create a request to change your limits. You will be prompted for that if you
 try to create such instance manually and your limits are not high enough. 

 3. install nvidia drivers on ec2 machine
 ```
 docker-machine ssh aws-01
 
 # Install NVIDIA drivers 361.45.18
 sudo apt-get install --no-install-recommends -y gcc make libc-dev
 wget -P /tmp http://us.download.nvidia.com/XFree86/Linux-x86_64/361.45.18/NVIDIA-Linux-x86_64-361.45.18.run
 sudo sh /tmp/NVIDIA-Linux-x86_64-361.45.18.run --silent
 
 # Install nvidia-docker and nvidia-docker-plugin
 wget -P /tmp https://github.com/NVIDIA/nvidia-docker/releases/download/v1.0.0-rc.3/nvidia-docker_1.0.0.rc.3-1_amd64.deb
 sudo dpkg -i /tmp/nvidia-docker*.deb && rm /tmp/nvidia-docker*.deb
 
 sudo docker run -it --rm $(ls /dev/nvidia* | xargs -I{} echo '--device={}') aocenas/keras-rnn:gpu
 ```
 Make sure you have correct drivers installed (here 361.45.18) as you can get a driver version mismatch when running the
 container.
 
#### TODO:
- [ ] check different base dockerfiles
- [ ] measure performance docker/non docker
- [ ] check what is the nvidia-docker doing as it is working with normal docker command
- [ ] try running on Spark
 
 
#### links:
- https://github.com/NVIDIA/nvidia-docker/wiki/Deploy-on-Amazon-EC2
- https://hub.docker.com/r/gw000/keras/
