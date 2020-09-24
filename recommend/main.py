import numpy as np
import pandas as pd
from sklearn import preprocessing
from sklearn.metrics.pairwise import cosine_similarity

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


class ShortTerm():
    def __init__(self, hangouts, user_lt, answers):
        self.hangouts = hangouts
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
    def __init__(self, hangouts, lt_trand, answers, covid_risk):
        self.ppc = PreProcessing()
        self.hangouts = self.ppc.get_all_features(hangouts)
        self.lt_trand = self.ppc.get_user_features(lt_trand)
        self.answers = self.ppc.get_answers(answers)
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
        shortterm = ShortTerm(self.hangouts, self.lt_trand, self.answers)
        user_st = shortterm.run(self.answers)
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
        self.all_users = self.ppc.get_all_features(all_users)
        self.user = self.ppc.get_user_features(user)
        self.mm = preprocessing.MinMaxScaler()

    def calc_euclid(self):
        results = []
        for i, other in enumerate(self.all_users):
            results.append(np.linalg.norm(other - self.user))
        results = np.array(results).reshape(-1,1)
        return self.mm.fit_transform(results)
        
    def calc_cos_simi(self):
        results = []
        for i, other in enumerate(self.all_users):
            results.append(cosine_similarity(other.reshape(-1,4), self.user.reshape(-1,4)))
        results = np.array(results).reshape(-1,1)
        return results
    
    def calc_eval(self):
        euclid_vals = self.calc_euclid()
        simi_vals = self.calc_cos_simi()
        eval_vals = euclid_vals - simi_vals
        return eval_vals
    
    def get_ranking(self, eval_vals):
        return np.argsort(eval_vals.ravel()) + 1
    
    def run(self):
        eval_vals = self.calc_eval()
        recom = self.get_ranking(eval_vals)
        return dict(r1=int(recom[0]), 
                    r2=int(recom[1]), 
                    r3=int(recom[2]), 
                    r4=int(recom[3]), 
                    r5=int(recom[4]))