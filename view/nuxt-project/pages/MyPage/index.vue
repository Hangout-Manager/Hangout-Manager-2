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
                <h1 style="text-align:left">ようこそ{{ user.name }}さん</h1>
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
                      <v-list-item-content>メールアドレス</v-list-item-content>
                      <v-list-item-content class="align-end">{{ user.email }}</v-list-item-content>
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
                        :to="{name: 'MyPage-Followings'}"
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
                        :to="{name: 'MyPage-Followers'}"
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
                <v-btn color="#FF6D00" block dark to='/EditProfile'>プロフィールの編集</v-btn>
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
      followings: [],
      followers: [],
    }
  },
  methods: {
    signOut: function() {
      const url = 'http://localhost:3000/api/auth/sign_out'
      axios.delete(url, {
        headers: { 
          "Content-Type": "application/json", 
          "access-token": localStorage.getItem('access-token'),
          "client": localStorage.getItem('client'),
          "uid": localStorage.getItem('uid')
        }
      }).then(
        this.$router.push('/'),
        localStorage.removeItem('access-token'),
        localStorage.removeItem('client'),
        localStorage.removeItem('uid')
      )
    }
  },
  created() {
    const user_url = 'http://localhost:3000/api/v1/show'
    axios.get(user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.user = response.data.data
      })
    const profile_url = 'http://localhost:3000/api/v1/profile'
    axios.get(profile_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.profile = response.data.data
      })
    const following_url = 'http://localhost:3000/api/v1/current_get_followings'
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
    const followers_url = 'http://localhost:3000/api/v1/current_get_followers'
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
