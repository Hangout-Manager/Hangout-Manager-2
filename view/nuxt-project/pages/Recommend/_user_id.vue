<template>
  <div>
    <v-container>
      <v-row>
        <v-col>
          <p>{{ recommend }}</p>
        </v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r1"><p>{{ hangout.id }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r2"><p>{{ hangout.id }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r3"><p>{{ hangout.id }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r4"><p>{{ hangout.id }}</p><p>{{ hangout.name }}</p></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r5"><p>{{ hangout.id }}</p><p>{{ hangout.name }}</p></v-col>
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
    const recommend_url = 'http://localhost:3000/api/v1/get_recommend/' + this.$route.params.user_id + '/' + this.$route.params.user_id
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
