from flask import Flask, render_template

app = Flask(__name__)

@app.route("/")
def hello_world():
    return render_template('index.html')


# If we are running this script (server.py) directly, 
# run the flask app. This is an alternative method to
# needing to (1) export the environemnt variable FLASK_APP=server
# and (2) needing to run flask run.
if __name__ == "__main__":
    app.run(debug=True)