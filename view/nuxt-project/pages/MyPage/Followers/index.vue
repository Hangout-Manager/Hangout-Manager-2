<template>
  <div>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <v-card>
          <v-card-title class="subheading font-weight-bold">フォロワー</v-card-title>
          <v-divider></v-divider>
          <v-simple-table>
            <thead>
              <tr>
                <th class="text-left"><b>名前</b></th>
                <th class="text-left"><b>メールアドレス</b></th>
              </tr>
            </thead>
            <tbody> 
              <tr v-for="(follower, i) in followers" :key="i">
                <td class="text-left">{{ follower.name }}</td>
                <td class="text-left">{{ follower.email }}</td>
              </tr>
            </tbody>
          </v-simple-table>
        </v-card>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters, mapMutations } from 'vuex'
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
        // "access-token": localStorage.getItem('access-token'),
        // "client": localStorage.getItem('client'),
        // "uid": localStorage.getItem('uid'),
        "access-token": this.$store.state.accessToken,
        "client": this.$store.state.client,
        "uid": this.$store.state.uid,
      }
    })
      .then(response => {
        this.followers = response.data.data
      })
  }
}
</script>
