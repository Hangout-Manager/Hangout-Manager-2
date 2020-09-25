<template>
  <div>
    <v-row>
      <v-col cols="3"></v-col>
      <v-col cols="6">
        <v-card>
          <v-card-title class="subheading font-weight-bold">フォロー</v-card-title>
          <v-row>
            <v-col cols="4" v-for="follower in followers" :key="follower.id">
              <v-btn color="black" dark block text :to="{name:'user', params:{id:follower.id}}">{{ follower.name }}</v-btn>
            </v-col>
          </v-row>
        </v-card>
      </v-col>
      <v-col cols="3"></v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      followers: [],
    }
  },
  created() {
    const followers_url = 'http://localhost:3000/api/v1/current_get_followers'
    axios.get(followers_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.followers = response.data.data
      })
  }
}
</script>
