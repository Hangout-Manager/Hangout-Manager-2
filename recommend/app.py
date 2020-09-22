from flask import *
import requests
import json
import urllib3

app = Flask(__name__)
http = urllib3.PoolManager()

@app.route("/hello/<post_id>")
def hello(post_id):
    url = 'http://api:3000/posts/' + post_id
    res = http.request('GET',url)
    data = json.loads(res.data.decode('utf-8'))
    print (data)
    return res.data.decode('utf-8')

## おまじない
if __name__ == "__main__":
    app.run(debug=True)
