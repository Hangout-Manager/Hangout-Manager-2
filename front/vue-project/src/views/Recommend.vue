<template>
  <div>
    <v-container>
      <v-row>
        <v-col>
          <h1>これらの遊びはいかがですか？</h1>
        </v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r1"><v-card @click="onClickPost()"><v-card-text>安全度：{{ recommend.r1_risk }}</v-card-text><v-card-title>{{ hangout.name }}</v-card-title></v-card></v-col>
        <post ref="post"/> 
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r2"><v-card><v-card-text>安全度：{{ recommend.r2_risk }}</v-card-text><v-card-title>{{ hangout.name }}</v-card-title></v-card></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r3"><v-card><v-card-text>安全度：{{ recommend.r3_risk }}</v-card-text><v-card-title>{{ hangout.name }}</v-card-title></v-card></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r4"><v-card><v-card-text>安全度：{{ recommend.r4_risk }}</v-card-text><v-card-title>{{ hangout.name }}</v-card-title></v-card></v-col>
      </v-row>
      <v-row v-for="hangout in hangouts" :key="hangout.id">
        <v-col v-if="hangout.id==recommend.r5"><v-card><v-card-text>安全度：{{ recommend.r5_risk }}</v-card-text><v-card-title>{{ hangout.name }}</v-card-title></v-card></v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'
import Post from '@/components/Post.vue'

export default {
  data () {
    return {
      recommend: [],
      hangouts: [],
    }
  },
  components: {
    Post
  },
  methods: {
    open () {
    },
    onClickPost() {
      this.$refs.post.open();
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
