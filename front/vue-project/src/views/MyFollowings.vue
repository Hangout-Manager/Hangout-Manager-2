<template>
  <div>
    <v-row>
      <v-col cols="3"></v-col>
      <v-col cols="6">
        <v-card>
          <v-card-title class="subheading font-weight-bold">フォロー</v-card-title>
          <v-row>
            <v-col cols="4" v-for="following in followings" :key="following.id">
              <v-btn color="black" dark block text :to="{name:'user', params:{id:following.id}}">{{ following.name }}</v-btn>
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
      followings: [],
    }
  },
  created() {
    const following_url = 'http://localhost:3000/api/v1/current_get_followings'
    axios.get(following_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.followings = response.data.data
      })
  }
}
</script>
