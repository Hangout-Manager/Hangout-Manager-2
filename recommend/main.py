import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.metrics.pairwise import cosine_similarity
import pickle

class PreProcessing():
    def get_all_features(self, dataset):
        features = []
        for _, data in enumerate(dataset):
            features.append([data["agon"],
                             data["alea"],
                             data["mimicry"], 
                             data["ilinx"]])
        return np.array(features)
                           
    def get_user_features(self, lt_trand):
        return np.array([lt_trand["agon"], 
                         lt_trand["alea"], 
                         lt_trand["mimicry"],
                         lt_trand["ilinx"]])
    
    def get_answers(self, answers):
        return np.array([answers[0]["q1"], answers[0]["q2"]])

    def get_all_risks(self, dataset):
        all_risks = []
        for _, data in enumerate(dataset):
            all_risks.append(data["value"])
        return np.array(all_risks)

    def get_users_id(self, all_users):
        users_info = []
        for _, user in enumerate(all_users):
            users_info.append([user["id"], user["user_id"]])
        return np.array(users_info)

    # def get_covid_answers(self, covid_ans):
    #     return np.array([covid_ans[0]["q1"], covid_ans[0]["q2"], covid_ans[0]["q3"]])

    # def get_new_hangout_id(self, covid_ans):
    #     return covid_ans[0]["id"]


class ShortTerm():
    def __init__(self, user_lt, answers):
        self.user_lt = user_lt
        self.answers = self.preprocessing(answers)    
        self.user_st = np.zeros(4)
                           
    def preprocessing(self, anss):
        q1 = ((anss[0] - 1) * 25) / 100
        q2 = ((anss[1] - 1) * 25) / 100
        return np.array([q1,q2])
        
    def calc_st_trand(self, q1, q2, alpha):
        agon    = (alpha * self.user_lt[0] 
                + (1 - alpha) * 0.5 * ((1-self.answers[0]) + self.answers[1]))
        alea    = (alpha * self.user_lt[1] 
                + (1 - alpha) * 0.5 * ((1-self.answers[0]) + (1-self.answers[1])))
        mimicry = (alpha * self.user_lt[2]
                + (1 - alpha) * 0.5 * (self.answers[0] + (1-self.answers[1])))
        ilinx   = (alpha * self.user_lt[3]
                + (1 - alpha) * 0.5 * (self.answers[0] + self.answers[1]))
        self.update([agon,alea,mimicry,ilinx])
    
    def update(self, elements):
        for i, element in enumerate(elements):
            self.user_st[i] = element
    
    def run(self, anss):
        q1, q2 = self.preprocessing(anss)
        self.calc_st_trand(q1, q2, alpha=0.75)
        return self.user_st        


class HangoutsRecommender():
    def __init__(self, hangouts, lt_trand, st_ans, covid_risk):
        self.ppc = PreProcessing()
        self.hangouts = self.ppc.get_all_features(hangouts)
        self.lt_trand = self.ppc.get_user_features(lt_trand)
        self.st_ans = self.ppc.get_answers(st_ans)
        self.covid_risk = self.ppc.get_all_risks(covid_risk)
        
    def get_recommend(self, user_st):
        results =  np.linalg.norm(self.hangouts - user_st, axis=1)
        return np.argsort(results)
    
    def get_ranking(self, rec_index):
        add_covid = np.zeros((5,2))
        for i, ho_idx in enumerate(rec_index):
            add_covid[i,0] = ho_idx
            add_covid[i,1] = self.covid_risk[ho_idx]
        return add_covid[:,0] + 1, add_covid[:,1]
        
    def run(self):
        shortterm = ShortTerm(self.lt_trand, self.st_ans)
        user_st = shortterm.run(self.st_ans)
        recommend = self.get_recommend(user_st)
        ranking, risk = self.get_ranking(recommend[:5])
        return dict(r1=int(ranking[0]), r1_risk=int(risk[0]),
                    r2=int(ranking[1]), r2_risk=int(risk[1]),
                    r3=int(ranking[2]), r3_risk=int(risk[2]),
                    r4=int(ranking[3]), r4_risk=int(risk[3]),
                    r5=int(ranking[4]), r5_risk=int(risk[4]))
                           
                  
class FriendsRecommender():
    def __init__(self, all_users, user):
        self.ppc = PreProcessing()
        self.users_feat = self.ppc.get_all_features(all_users)
        self.users_id = self.ppc.get_users_id(all_users)
        self.user = self.ppc.get_user_features(user)
        self.mm = preprocessing.MinMaxScaler()

    def calc_euclid(self):
        results = []
        for i, user_feat in enumerate(self.users_feat):
            results.append(np.linalg.norm(user_feat - self.user))
        results = np.array(results).reshape(-1,1)
        return self.mm.fit_transform(results)
        
    def calc_cos_simi(self):
        results = []
        for i, user_feat in enumerate(self.users_feat):
            results.append(cosine_similarity(
                user_feat.reshape(-1,4), self.user.reshape(-1,4)))
        results = np.array(results).reshape(-1,1)
        return results
    
    def calc_eval(self):
        euclid_vals = self.calc_euclid()
        simi_vals = self.calc_cos_simi()
        eval_vals = euclid_vals - simi_vals
        return eval_vals

    def comb_users_id(self, eval_vals):
        return np.hstack([eval_vals, self.users_id])
    
    def get_ranking(self, eval_vals):
        return eval_vals[np.argsort(eval_vals[:,0])]

    def run(self):
        eval_vals = self.calc_eval()
        comb_evals = self.comb_users_id(eval_vals)
        ranked_id = self.get_ranking(comb_evals)
        return dict(r1=int(ranked_id[0,2]), 
                    r2=int(ranked_id[1,2]), 
                    r3=int(ranked_id[2,2]), 
                    r4=int(ranked_id[3,2]), 
                    r5=int(ranked_id[4,2]))


# class HangoutsFeatureCalculation():
#     def __init__(self, user, st_ans, covid_ans):
#         self.user = self.ppc.get_user_features(user)
#         self.st_ans = self.ppc.get_answers(st_ans)
#         self.covid_ans = self.ppc.get_covid_answers(covid_ans)
#         self.new_ho_id = self.ppc.get_new_hangout_id(covid_ans)
#         self.cons_st_trend = ShortTerm(user, st_ans)
    
#     def get_st_trend_feat(self,) 

    


