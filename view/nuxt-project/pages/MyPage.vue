<template>
  <div>
    <v-container>
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
              <v-list-item>
                <v-list-item-content>フォロー</v-list-item-content>
                <v-list-item-content class="align-end">23</v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>フォロワー</v-list-item-content>
                <v-list-item-content class="align-end">23</v-list-item-content>
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
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      data: [
        localStorage.getItem('access-token'),
        localStorage.getItem('client'),
        localStorage.getItem('uid')
      ],
      user: [],
      profile: [],
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
    const user_url = 'http://localhost:3000/api/v1/users/show'
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
    const profile_url = 'http://localhost:3000/api/v1/users/profile'
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
  }
}
</script>
