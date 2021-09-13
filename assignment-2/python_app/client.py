import socket
import time
import signal
import sys
import os
import random
import json

HOST = os.environ['SERVER_HOSTNAME']
PORT = int(os.environ['SERVER_PORT'])
print(f'ENV VARS: SERVER_HOSTNAME:{HOST} SERVER_PORT:{PORT}')

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
            print(f"Connected to {HOST} on port {PORT}")
            s.sendall(generate_request())
            resp = s.recv(1024)
            resp = json.loads(resp.decode('utf-8'))
            print(f"Server response: {resp}")
            time.sleep(5)
    except socket.error:
        print(f"Connection to {HOST} on port {PORT} FAILED, Retrying...")
        time.sleep(1)

