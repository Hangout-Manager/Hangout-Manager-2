<template>
  <div>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <v-card>
          <v-card-title class="subheading font-weight-bold">フォロー</v-card-title>
          <v-divider></v-divider>
          <v-simple-table>
            <thead>
              <tr>
                <th class="text-left"><b>名前</b></th>
                <th class="text-left"><b>メールアドレス</b></th>
              </tr>
            </thead>
            <tbody> 
              <tr v-for="(following, i) in followings" :key="i">
                <td class="text-left">{{ following.name }}</td>
                <td class="text-left">{{ following.email }}</td>
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
      followings: [],
    }
  },
  created() {
    const following_url = 'http://localhost:3000/api/v1/get_followings/' + this.$route.params.user_id
    axios.get(following_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.followings = response.data.data
      })
  }
}
</script>
