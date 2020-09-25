<template>
  <div>
  <v-row justify="center">
    <v-dialog v-model="show" max-width="1200">
      <v-card>
        <v-card-title>
          <span class="headline">あそびを投稿する</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-text-field label="タイトル" v-model="title" required></v-text-field>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-text-field label="内容" v-model="content" outlined height="200" rows="4" row-height="20" required></v-text-field>
              </v-col>
            </v-row>
            <v-row>
            </v-row>
            <v-row>
              <v-col cols="2"></v-col>
              <v-col cols="8">
              <v-card-title>開始はいつ？</v-card-title>
              </v-col>
              <v-col cols="2"></v-col>
            </v-row>
            <v-row justify="center">
              <v-col cols="2"></v-col>
              <v-col cols="4">
              <v-date-picker v-model="pickerDate"></v-date-picker>
              </v-col>
              <v-col cols="4">
                <v-time-picker v-model="pickerTime"></v-time-picker>
              </v-col>
              <v-col cols="2"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-slider
                  v-model="estimate_time"
                  :rules="rules.estimate_time"
                color="orange"
                ticks="always"
                min="0"
                max="24"
                label="想定時間(時間)"
                thumb-label="always"
                ></v-slider>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-slider
                  v-model="upper_number"
                  :rules="rules.upper_number"
                color="orange"
                ticks="always"
                min="0"
                max="10"
                label="募集人数"
                thumb-label="always"
                ></v-slider>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="4">
                <v-text-field label="タグ" v-model="tag" required></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn color="blue darken-1" dark @click="show=false">閉じる</v-btn>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" dark @click="post">投稿</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'post',
  data () {
    return {
      show: false,
      title: '',
      content: '',
      tag: '',
      user: [],
      upper_number: [],
      pickerDate: new Date().toISOString().substr(0, 10),
      pickerTime: null,
      estimate_time: [],
      rules: {
        upper_number: [
          val => val < 20
          ],
        estimate_time: [
          val => val < 24
          ],
      }
    }
  },
  created() {
    const show_url = 'http://localhost:3000/api/v1/show'
    axios.get(show_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    }
    )
      .then(response => {
        this.user = response.data.data
      })
  },
  methods: {
    open () {
      this.show = true
    },
    post: function() {
      const url = 'http://localhost:3000/posts'
      var params = new URLSearchParams();
      params.append('title', this.title);
      params.append('content', this.content);
      params.append('label_id', "1");
      params.append('upper_number', this.upper_number);
      params.append('start_date', this.pickerDate);
      params.append('start_time', this.pickerTime);
      params.append('estimate_time', this.estimate_time);
      params.append('tag', this.tag);
      params.append('user_id', this.user.id);
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      axios.post(url, params).then(
        () => {
          this.$router.push('/MyPage')
          this.show = false
          this.$router.go({path: this.$router.currentRoute.path, force: true})
    },
      )
    }
  }
}
</script>
