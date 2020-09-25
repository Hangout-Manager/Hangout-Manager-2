<template>
  <div>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <h1>どんな遊びですか？</h1>
        <hr>
      </v-col>
      <v-col cols="1"></v-col>
    </v-row>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <v-card>
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <p style="text-align:center">あそびの名前はなんですか？</p>
              <v-text-field outlined label="名前" v-model="name" required></v-text-field>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <p style="text-align:center">Q1．物を共有するあそびですか？</p>
              <p style="text-align:center">(0:共有しない ーーーーーーーー 10:共有する)</p>
              <br>
              <v-slider
                v-model="q1"
                :rules="rules.q1"
                color="orange"
                ticks="always"
                min="0"
                max="10"
                thumb-label="always"
                ></v-slider>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <p style="text-align:center">Q2．室外でするあそびですか？室内でするあそびですか？</p>
              <p style="text-align:center">(0:室外 ーーーーーーーー 10:室内)</p>
              <br>
              <v-slider
                v-model="q2"
                :rules="rules.q2"
                color="orange"
                ticks="always"
                min="0"
                max="10"
                thumb-label="always"
                ></v-slider>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <p style="text-align:center">Q3．あそぶ場所は人が密集してますか？</p>
              <p style="text-align:center">(0:過疎 ーーーーーーーー 10:密集)</p>
              <br>
              <v-slider
                v-model="q3"
                :rules="rules.q3"
                color="orange"
                ticks="always"
                min="0"
                max="10"
                thumb-label="always"
            ></v-slider>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row >
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <p style="text-align:center">今，非日常を体験したいですか？</p>
              <v-select
                v-model.number="q4"
                :items="q4_list"
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
              <p style="text-align:center">今，ゆったりのんびりあそびたいですか？<br>エキサイティングなあそびをしたいですか？</p>
              <v-select
                v-model.number="q5"
                :items="q5_list"
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
              <v-btn large block color="primary" @click="register">登録</v-btn>
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
      name: [],
      q1: [],
      q2: [],
      q3: [],
      rules: {
        q1: [
          val => val < 10
          ],
        q2: [
          val => val < 10
          ],
        q3: [
          val => val < 10
          ],
      },
      q4: [],
      q5: [],
      q4_list: [
        { name: "絶対したくない", id: 1 },
        { name: "したくない", id: 2 },
        { name: "どちらでもよい", id: 3 },
        { name: "したい", id: 4 },
        { name: "絶対したい", id: 5 },
      ],
      q5_list: [
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
      const register_url = 'http://localhost:3000/api/v1/create_new_hangout'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('name', this.name);
      params.append('q1', this.q1);
      params.append('q2', this.q2);
      params.append('q3', this.q3);
      params.append('q4', this.q4);
      params.append('q5', this.q5);
      params.append('user_id', this.user.id);
      axios.post(register_url, params).then(
        () => {
          this.$router.push('MyPage')
        },
        (error) => {
          return error
        })
    }
  }
}
</script>
