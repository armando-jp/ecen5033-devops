sudo docker build -t py-client . 
sudo docker tag py-client 192.168.33.10:5000/py-client
sudo docker push 192.168.33.10:5000/py-client