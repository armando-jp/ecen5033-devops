from flask import Flask

app = Flask(__name__)

VERSION_TAG = "V1"

@app.route("/")
def hello_world():
    return f"The application works. Build {VERSION_TAG}\n"


# If we are running this script (server.py) directly, 
# run the flask app. This is an alternative method to
# needing to (1) export the environemnt variable FLASK_APP=server
# and (2) needing to run flask run.
if __name__ == "__main__":
    app.run(debug=False, host='0.0.0.0', port=8080)