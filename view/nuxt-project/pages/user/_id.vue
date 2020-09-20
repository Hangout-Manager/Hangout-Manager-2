<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <h1 style="text-align:left">{{ user.name }}さんのページ</h1>
          <hr>
        </v-col>
        <v-col cols="1"></v-col>
      </v-row>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="3">
          <v-card>
            <v-card-title class="subheading font-weight-bold">プロフィール</v-card-title>
            <v-divider></v-divider>
            <v-list>
              <v-list-item>
                <v-list-item-content>名前</v-list-item-content>
                <v-list-item-content class="align-end">{{ user.name }}</v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>出身地</v-list-item-content>
                <v-list-item-content class="align-end">{{ profile.place }}</v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>年齢</v-list-item-content>
                <v-list-item-content class="align-end">{{ profile.age }}</v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>性別</v-list-item-content>
                <v-list-item-content class="align-end">{{ profile.sex }}</v-list-item-content>
              </v-list-item>
            </v-list>
          </v-card>
        </v-col>
        <v-col cols="7">
          <v-card>
            <v-card-title class="subheading font-weight-bold">{{ user.name }}が予定しているあそび</v-card-title>
            <v-divider></v-divider>
            <v-simple-table>
              <thead>
                <tr>
                  <th class="text-left">Name</th>
                  <th class="text-left">Calories</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="text-left">テスト</td>
                  <td class="text-left">テスト</td>
                </tr>
              </tbody>
            </v-simple-table>
            <v-card-title class="subheading font-weight-bold">{{ user.name }}が予定しているあそび</v-card-title>
            <v-divider></v-divider>
            <v-simple-table>
              <thead>
                <tr>
                  <th class="text-left">Name</th>
                  <th class="text-left">Calories</th>
                </tr>
              </thead>
              <tbody>
                <tr>
                  <td class="text-left">テスト</td>
                  <td class="text-left">テスト</td>
                </tr>
              </tbody>
            </v-simple-table>
          </v-card>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="3">
          <v-row>
            <v-col cols="6">
              <v-hover v-slot:default="{ hover }">
                <v-card
                  :elevation="hover ? 12 : 2"
                  :class="{ 'on-hover': hover }"
                  :to="{
                       name: 'user-user_id-Followings',
                       params: {
                       user_id:user.id
                       }
                       }"
                  >
                  <v-card-text>フォロー</v-card-text>
                  <v-card-title>{{ followings.length }}</v-card-title>
                </v-card>
              </v-hover>
            </v-col>
            <v-col cols="6">
              <v-hover v-slot:default="{ hover }">
                <v-card
                  :elevation="hover ? 12 : 2"
                  :class="{ 'on-hover': hover }"
                  :to="{
                       name: 'user-user_id-Followers',
                       params: {
                       user_id:user.id
                       }
                       }"
                  >
                  <v-card-text>フォロワー</v-card-text>
                  <v-card-title>{{ followers.length }}</v-card-title>
                </v-card>
              </v-hover>
            </v-col>
          </v-row>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="3">
          <v-btn v-if="isNotfollow" color="#1976D2" block dark @click="follow">フォロー</v-btn>
          <v-btn v-else="isNotfollow" color="#AD1457" block dark @click="unfollow">フォローを外す</v-btn>
        </v-col>
      </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      user: [],
      profile: [],
      current_user: [],
      isNotfollow: [],
      followings: [],
      followers: []
    }
  },
  methods: {
    follow: function() {
      const follow_url = 'http://localhost:3000/follow'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('user_id', this.current_user.id);
      params.append('follow_id', this.user.id);
      axios.post(follow_url, params).then(
        this.isNotfollow = false
      )
    },
    unfollow: function() {
      const unfollow_url = 'http://localhost:3000/unfollow'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('follow_id', this.user.id);
      params.append('user_id', this.current_user.id);
      axios.post(unfollow_url, params).then(
        this.isNotfollow = true
      )
    }
  },
  created() {
    const user_url = `http://localhost:3000/api/v1/get_user/${this.$route.params.id}`
    axios.get(user_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.user = response.data.data.user
        this.profile = response.data.data
      })
    const current_user_url = 'http://localhost:3000/api/v1/show'
    axios.get(current_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.current_user = response.data.data
      })
    const is_follow_url = 'http://localhost:3000/isfollow/' + this.$route.params.id
    axios.get(is_follow_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.isNotfollow = response.data.data
      })
    const following_url = 'http://localhost:3000/api/v1/get_followings/' + this.$route.params.id
    axios.get(following_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.followings = response.data.data
      })
    const followers_url = 'http://localhost:3000/api/v1/get_followers/' + this.$route.params.id
    axios.get(followers_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.followers = response.data.data
      })
  }
}
</script>
