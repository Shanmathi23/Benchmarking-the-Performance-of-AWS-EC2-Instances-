#!/bin/bash

sudo apt-get update 
#Install the required softwares needed
sudo apt-get install build-essential libpcre3 libpcre3-dev libssl-dev unzip -y

#Install the nginx source code - Version 1.8.1 
mkdir nginx
cd nginx
wget http://nginx.org/download/nginx-1.8.1.tar.gz
tar -zxvf nginx-1.8.1.tar.gz

#Source for Nginx-RTMP
wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
unzip master.zip

#Configure nginx server
cd nginx-1.8.1
./configure --with-http_ssl_module --add-module=../nginx-rtmp-module-master

#make and install nginx
make
sudo make install

#Add the code to configure the RTMP module
sudo echo -e "rtmp {\n   server {\n \tlisten 1935;\n\tchunk_size 8192;\n\tapplication vod {\n\t\tplay /usr/local/nginx/rtmp;\n   }\n  }\n   \n}" >> /usr/local/nginx/conf/nginx.conf

#make dir for video files to stream
sudo mkdir /usr/local/nginx/rtmp
wget http://www.sample-videos.com/video/mp4/720/big_buck_bunny_720p_1mb.mp4
echo "Give some time to transfer of files plzz :P"
sudo cp big_buck_bunny_720p_1mb.mp4 /usr/local/nginx/rtmp


#Start nginx server
sudo /usr/local/nginx/sbin/nginx

echo "Done !!! Hopefully server is running .. Try rtmp req from client -> rtmp://******:****/vod/big_buck_bunny_720p_1mb.mp4"
