<template>
  <div>
  <v-row justify="center">
    <v-dialog v-model="show" max-width="1200">
      <v-card>
        <v-card-title>
          <span class="headline">コメントをする</span>
          <span class="headline">{{ post_id }}</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-text-field label="コメント" v-model="content" outlined height="200" rows="4" row-height="20" required></v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn color="blue darken-1" dark @click="show=false">閉じる</v-btn>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" dark @click="comment">コメントする</v-btn>
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
      user: []
    }
  },
  created() {
    const show_url = 'http://localhost:3000/api/v1/show'
    axios.get(show_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": this.$store.state.accessToken,
        "client": this.$store.state.client,
        "uid": this.$store.state.uid,
        // "Content-Type": "application/json", 
        // "access-token": localStorage.getItem('access-token'),
        // "client": localStorage.getItem('client'),
        // "uid": localStorage.getItem('uid')
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
    comment: function() {
      const url = 'http://localhost:3000/comment/' + this.user.id
      var params = new URLSearchParams();
      params.append('content', this.content);
      params.append('post_id', this.post_id);
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      axios.post(url, params).then(
        (response) => {
          this.$router.push('MyPage')
          this.show = false
    },
      )
    }
  }
}
</script>
