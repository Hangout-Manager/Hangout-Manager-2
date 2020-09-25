<template>
  <div>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <h1>質問</h1>
        <hr>
      </v-col>
      <v-col cols="1"></v-col>
    </v-row>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <v-card>
          <v-row >
            <v-col cols="4"></v-col>
          </v-row>
          <v-row >
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <h2>非日常を体験したいですか？</h2>
              <v-select
                v-model.number="q1"
                :items="q1_list"
                :menu-props="{ top: true, offsetY: true }"
                label="回答"
                outlined
                item-text="name"
                item-value="id"
                ></v-select>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row >
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <h2>ゆったりのんびりあそびたいですか？<br>エキサイティングなあそびをしたいですか？</h2>
              <v-select
                v-model.number="q2"
                :items="q2_list"
                :menu-props="{ top: true, offsetY: true }"
                label="回答"
                outlined
                item-text="name"
                item-value="id"
                ></v-select>
            </v-col>
          </v-row>
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <v-btn 
                large 
                color="primary" 
                @click="register"
                >
                回答
              </v-btn>
            </v-col> 
            <v-col cols="4"></v-col>
          </v-row>
        </v-card>
      </v-col>
      <v-col cols="1"></v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  data () {
    return {
      user: [],
      q1: [],
      q2: [],
      q1_list: [
        { name: "絶対したくない", id: 1 },
        { name: "したくない", id: 2 },
        { name: "どちらでもよい", id: 3 },
        { name: "したい", id: 4 },
        { name: "絶対したい", id: 5 },
      ],
      q2_list: [
        { name: "絶対ゆったりのんびりしたい！！", id: 1 },
        { name: "ゆったりのんびりしたい", id: 2 },
        { name: "どちらでもよい", id: 3 },
        { name: "エキサイティング", id: 4 },
        { name: "絶対エキサイティング！！", id: 5 },
      ],
    }
  },
  created() {
    const show_url = 'http://localhost:3000/api/v1/show'
    axios.get(show_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    }
    )
      .then(response => {
        this.user = response.data.data
      })
  },
  methods: {
    register: function() {
      const register_url = 'http://localhost:3000/questions'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('q1', this.q1);
      params.append('q2', this.q2);
      params.append('user_id', this.user.id);
      axios.post(register_url, params).then(
        () => {
          this.$router.push('Recommend/' + this.user.id)
        },
        (error) => {
          return error
        })
    }
  }
}
</script>
