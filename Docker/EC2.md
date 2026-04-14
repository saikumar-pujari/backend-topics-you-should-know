### CONNECTING DOCKER WITH EC2 BY CMD
mostly we will be working in the ec2 instances docker so connect your EC2 instance with CLI in CMD using the SSH.

before it change the permission for the .pem key in the WSL or BASH shell by CHMOD 400 <file_name>.pem else it will cause error

then in CMD use SSH -i <file_name>.pem host_name@IP (ssh -i na.pem ubuntu@127.0.0.1)

then you will enter the EC2 instances now change the user to root using sudo -i

then apt updates

then apt install docker.io -y

then systemctl status docker   ,if docker is inactive use systemctl start docker before it systemctl enable docker

check for any images by docker images or containter by docker ps -a
```
c:/User/downloads: CHMOD 400 na.pem
c:/User/downloads: ssh -i na.pem ubuntu@172-31-39-00
ubuntu@ip-172-31-39-00:~$ sudo -i
root@ip-172-31-39-00:~# apt updates
root@ip-172-31-39-00:~# apt install docker.io -y
root@ip-172-31-39-00:~# systemctl start docker
root@ip-172-31-39-00:~# docker images
root@ip-172-31-39-00:~# docker ps -a
```
