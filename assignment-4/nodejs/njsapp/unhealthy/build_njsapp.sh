sudo docker build -t njsapp-bug .
sudo docker tag njsapp-bug 192.168.33.10:5000/njsapp-bug
sudo docker push 192.168.33.10:5000/njsapp-bug
