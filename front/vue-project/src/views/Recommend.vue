<template>
  <div>
    <v-container>
      <v-row>
        <v-col>
          <h1>これらの遊びはいかがですか？</h1>
        </v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r1"><p>安全度：{{ recommend.r1_risk }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r2"><p>安全度：{{ recommend.r2_risk }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r3"><p>安全度：{{ recommend.r3_risk }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r4"><p>安全度：{{ recommend.r4_risk }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r5"><p>安全度：{{ recommend.r5_risk }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      recommend: [],
      hangouts: [],
    }
  },
  created() {
    const recommend_url = 'http://localhost:3000/api/v1/get_recommend/' + this.$route.params.user_id 
    axios.get(recommend_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.recommend = response.data
  })
    const hangout_url = 'http://localhost:3000/hangouts'
    axios.get(hangout_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.hangouts = response.data
  })
  }
}
</script>
