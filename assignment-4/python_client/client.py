import os
import requests
import time

HOST = os.environ['SERVER_HOSTNAME']
PORT = int(os.environ['SERVER_PORT'])
print(f'ENV VARS: SERVER_HOSTNAME:{HOST} SERVER_PORT:{PORT}')

while True:
    try: 
        r = requests.get(f'http://{HOST}:{PORT}')
        print(f"Server response: {r.content}")
        time.sleep(5)

    except requests.exceptions.RequestException as e:
        print(f"Connection to {HOST} on port {PORT} FAILED, Retrying...")
        time.sleep(1)

