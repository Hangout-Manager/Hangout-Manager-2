from flask import *
import requests
import json
import urllib3

app = Flask(__name__)
http = urllib3.PoolManager()

@app.route("/hello")
def hello():
    return "hello"

## おまじない
if __name__ == "__main__":
    app.run(debug=True)
