<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card>
            <h1>{{ this.$route.params.id }}</h1>
            <h1>{{ recommend_friends }}</h1>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters, mapMutations } from 'vuex'

export default {
  data () {
    return {
      user: [],
      recommend_friends: []
    }
  },
  created() {
    // 現在のユーザー取得
    const current_user_url = 'http://localhost:3000/api/v1/show'
    axios.get(current_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": this.$store.state.accessToken,
        "client": this.$store.state.client,
        "uid": this.$store.state.uid,
        // "access-token": localStorage.getItem('access-token'),
        // "client": localStorage.getItem('client'),
        // "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.user = response.data.data
      })
    const recommend_user_url = 'http://localhost:3000/api/v1/get_friend_recommend/' + this.$route.params.id
    axios.get(recommend_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        // "access-token": this.$store.state.accessToken,
        // "client": this.$store.state.client,
        // "uid": this.$store.state.uid,
        // "access-token": localStorage.getItem('access-token'),
        // "client": localStorage.getItem('client'),
        // "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.recommend_friends = response.data
      })
  }
}
</script>
