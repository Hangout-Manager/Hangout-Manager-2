<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <h1>趣味が合いそうな友達が見つかりました</h1>
          <v-row v-for="user in users" :key="user.id">
            <v-col v-if="user.id==recommend_friends.r1">
              <v-card :to="{name:'user', params:{id:user.id}}">
                <v-card-title >{{ user.name }}</v-card-title>
              </v-card>
            </v-col>
          </v-row>
          <v-row v-for="user in users" :key="user.id">
            <v-col v-if="user.id==recommend_friends.r2">
              <v-card :to="{name:'user', params:{id:user.id}}">
                <v-card-title>{{ user.name }}</v-card-title>
              </v-card>
            </v-col>
          </v-row>
          <v-row v-for="user in users" :key="user.id">
            <v-col v-if="user.id==recommend_friends.r3">
              <v-card :to="{name:'user', params:{id:user.id}}">
                <v-card-title>{{ user.name }}</v-card-title>
              </v-card>
            </v-col>
          </v-row>
          <v-row v-for="user in users" :key="user.id">
            <v-col v-if="user.id==recommend_friends.r4">
              <v-card :to="{name:'user', params:{id:user.id}}">
                <v-card-title>{{ user.name }}</v-card-title>
              </v-card>
            </v-col>
          </v-row>
          <v-row v-for="user in users" :key="user.id">
            <v-col v-if="user.id==recommend_friends.r5">
              <v-card :to="{name:'user', params:{id:user.id}}">
                <v-card-title>{{ user.name }}</v-card-title>
              </v-card>
            </v-col>
          </v-row>
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
      users: [],
      recommend_friends: []
    }
  },
  created() {
    const url = 'http://localhost:3000/api/v1/index'
    axios.get(url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.users = response.data.data
      })

    // 現在のユーザー取得
    const current_user_url = 'http://localhost:3000/api/v1/show'
    axios.get(current_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.user = response.data.data
      })
    const recommend_user_url = 'http://localhost:3000/api/v1/get_friend_recommend/' + this.$route.params.id
    axios.get(recommend_user_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.recommend_friends = response.data
      })
  }
}
</script>
