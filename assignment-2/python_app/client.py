import socket
import time
import signal
import sys
import os
import random
import json

HOST = 'vagrant_server_1'
PORT = 6060

OPS = ['+', '-', '*', '/']

def signal_handler(sig, frame):
    print('You pressed Ctrl+C!')
    sys.exit(0)
signal.signal(signal.SIGINT, signal_handler)

def generate_request():
    req = {
        'val1' : random.randrange(1000),
        'val2' : random.randrange(1000),
        'operation': random.choice(OPS),
    }
    return json.dumps(req).encode('utf-8')

while True:
    try: 
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.connect((HOST, PORT))
            s.sendall(generate_request())
            resp = s.recv(1024)
            resp = json.loads(resp.decode('utf-8'))
            print(resp)
    except socket.error:
        print("Connection Failed, Retrying...")
        time.sleep(1)
    time.sleep(5)

