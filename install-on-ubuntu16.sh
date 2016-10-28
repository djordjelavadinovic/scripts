sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
apt-cache policy docker-engine
sudo apt-get update
sudo apt-get install linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get update
sudo apt-get install docker-engine
sudo service docker start
sudo docker run hello-world

cat <<TOEND

Please add option -H tcp://0.0.0.0:2375 to the and of the line:
ExecStart=/usr/bin/dockerd -H fd://
in the file docker.service:

$ sudo vi /etc/systemd/system/multi-user.target.wants/docker.service

Then reload configuration file using

$ sudo systemctl daemon-reload
$ sudo service docker restart

TOEND
