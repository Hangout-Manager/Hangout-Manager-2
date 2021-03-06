from flask import *
import requests
import json
import urllib3

from main import HangoutsRecommender
from main import FriendsRecommender
from main import HangoutsFeatureCalculation

app = Flask(__name__)
http = urllib3.PoolManager()

@app.route("/hangouts/<user_lt_trend_id>")
def hangouts_rec(user_lt_trend_id):
    url_hangouts = 'http://api:3000/hangouts/'
    res_hangouts = http.request('GET',url_hangouts)
    hangouts = json.loads(res_hangouts.data.decode('utf-8'))
    
    url_user_lt_trand = 'http://api:3000/api/v1/get_long_trend/' + user_lt_trend_id
    res_user_lt_trand = http.request('GET',url_user_lt_trand)
    user_lt_trand = json.loads(res_user_lt_trand.data.decode('utf-8'))

    url_answers = 'http://api:3000/api/v1/get_answer/' + user_lt_trend_id
    res_answers = http.request('GET',url_answers)
    answers = json.loads(res_answers.data.decode('utf-8'))
    
    url_risks = 'http://api:3000/risks'
    res_risks = http.request('GET',url_risks)
    risks = json.loads(res_risks.data.decode('utf-8'))
    
    hr = HangoutsRecommender(hangouts, user_lt_trand, answers, risks)
    results = hr.run()
    return results

@app.route("/friends/<user_lt_trend_id>")
def friends_rec(user_lt_trend_id):
    url_all_users = 'http://api:3000/long_trends_without_me/' + user_lt_trend_id
    res_all_users = http.request('GET',url_all_users)
    all_users = json.loads(res_all_users.data.decode('utf-8'))

    url_user_lt_trand = 'http://api:3000/api/v1/get_long_trend/' + user_lt_trend_id
    res_user_lt_trand = http.request('GET',url_user_lt_trand)
    user_lt_trand = json.loads(res_user_lt_trand.data.decode('utf-8'))
    
    fr = FriendsRecommender(all_users, user_lt_trand)
    results = fr.run()
    return results

@app.route("/additional/<user_lt_trend_id>/<q1>/<q2>/<q3>/<q4>/<q5>")
def additional(user_lt_trend_id, q1, q2, q3, q4, q5):
    # 対象ユーザーの情報を取得
    url_user_lt_trand = 'http://api:3000/api/v1/get_long_trend/' + user_lt_trend_id
    res_user_lt_trand = http.request('GET',url_user_lt_trand)
    user_lt_trand = json.loads(res_user_lt_trand.data.decode('utf-8'))
    
    hfc = HangoutsFeatureCalculation(user_lt_trand, [q1, q2, q3, q4, q5])
    results = hfc.run()
    return results

## おまじない
if __name__ == "__main__":
    app.run(debug=True)
