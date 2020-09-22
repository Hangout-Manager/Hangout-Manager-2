from flask import *
import requests
import json
import urllib3

from main import HangoutsRecommender
# from main import FriendsRecommender

app = Flask(__name__)
http = urllib3.PoolManager()

@app.route("/hangouts/<user_lt_trend_id>/<user_ans_id>")
def hangouts_rec(user_lt_trend_id, user_ans_id):
    url_hangouts = 'http://api:3000/hangouts/'
    res_hangouts = http.request('GET',url_hangouts)
    hangouts = json.loads(res_hangouts.data.decode('utf-8'))

    url_lt_trand = 'http://api:3000/api/v1/get_long_trend/' + user_lt_trend_id
    res_lt_trand = http.request('GET',url_lt_trand)
    lt_trand = json.loads(res_lt_trand.data.decode('utf-8'))

    url_answers = 'http://api:3000/api/v1/get_answer/' + user_ans_id
    res_answers = http.request('GET',url_answers)
    answers = json.loads(res_answers.data.decode('utf-8'))
    
    hor = HangoutsRecommender(hangouts, lt_trand, answers)
    results = hor.run()
    return results


# @app.route("/recommend/<post_id>/<post_id>/<post_id>")
# def hello(post_id):
#     url_hangouts = 'http://api:3000/posts/' + post_id
#     res_hangouts = http.request('GET',url_hangout_all)
#     hangouts = json.loads(res_hangouts.data.decode('utf-8'))

#     url_lt_trand = 'http://api:3000/posts/' + post_id
#     res_lt_trand = http.request('GET',url_lt_trand)
#     lt_trand = json.loads(res_lt_trand.data.decode('utf-8'))

#     url_answers = 'http://api:3000/posts/' + post_id
#     res_answers = http.request('GET',url_answers)
#     answers = json.loads(res_answers.data.decode('utf-8'))
    
#     # fh = FriendsRecommender([d1,d2,d3,d4,d5,d6,d7,d8],[q1,q2,q3])

#     return res.data.decode('utf-8')

## おまじない
if __name__ == "__main__":
    app.run(debug=True)
