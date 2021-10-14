sudo docker build -t njsapp .
sudo docker tag njsapp 192.168.33.10:5000/njsapp
sudo docker push 192.168.33.10:5000/njsapp
