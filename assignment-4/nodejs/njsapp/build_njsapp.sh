sudo docker build --no-cache -t njsapp .
sudo docker tag njsapp 192.168.33.10:5000/njsapp:v1
sudo docker push 192.168.33.10:5000/njsapp:v1