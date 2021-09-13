import socket
import os
import signal
import sys
import json
import operator

HOST = os.environ['SERVER_HOSTNAME']
PORT = int(os.environ['SERVER_PORT'])
print(f'ENV VARS: SERVER_HOSTNAME:{HOST} SERVER_PORT:{PORT}')


# Operator lookup table
ops = { 
    "+": operator.add, 
    "-": operator.sub,
    "*": operator.mul,
    "/": operator.truediv,
}

def signal_handler(sig, frame):
    print('You pressed Ctrl+C!')
    sys.exit(0)

signal.signal(signal.SIGINT, signal_handler)

def process_request(req: json) -> bytearray:
    val1 = int(req['val1'])
    val2 = int(req['val2'])
    operation = req["operation"]
    req['result'] = (ops[operation](val1, val2))

    return json.dumps(req).encode('utf-8')

while True:
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        s.bind((HOST, PORT))
        s.listen()
        conn, addr = s.accept() # this call is blocking 
        with conn:
            print('Connected by', addr)

            # Get request
            request = conn.recv(1024)
            request = json.loads(request.decode('utf-8'))
            print(f"Received from client: {request}")

            # Process request
            resp = process_request(request)

            # Send request
            conn.sendall(resp)