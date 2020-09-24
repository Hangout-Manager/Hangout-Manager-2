<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card>
            <v-row>
              <v-col>
                <v-chip v-if="post.label_id==1" class="ma-2" dark color="primary">募集中</v-chip>
                <v-chip v-if="post.label_id==2" class="ma-2" dark color="green">募集締め切り</v-chip>
                <v-chip v-if="post.label_id==3" class="ma-2" dark color="red">終了</v-chip>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-card-title>{{ post.title }}</v-card-title>
                <v-card-title>{{ isParticipated }}</v-card-title>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-card-text>参加者：</v-card-text>
                <v-card-text v-for="user in participated_users" :key="user.id">
                  - {{ user.name }}
                </v-card-text>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-card-text>{{ post.content }}</v-card-text>
              </v-col>
            </v-row>
            <v-row v-for="comment in comments" :key="comment.id">
              <v-col>
                <v-card-text>{{comment.user_id}}:{{ comment.content }}</v-card-text>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-chip class="ma-2" label>
                  {{ post.tag }}
                </v-chip>
              </v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-btn v-if="isParticipated" color="#AD1457" block dark @click="unparticipate">参加を取り消す</v-btn>
                <v-btn v-else="isParticipated" color="#1976D2" block dark @click="participate">参加する</v-btn>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-btn color="#AD1457" dark block @click="dialog=true">コメント</v-btn>
                <v-row justify="center">
                  <v-dialog
                    v-model="dialog"
                    max-width="600"
                    >
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
                        <v-btn color="blue darken-1" dark @click="dialog=false">閉じる</v-btn>
                        <v-spacer></v-spacer>
                        <v-btn color="blue darken-1" dark @click="comment">コメントする</v-btn>
                      </v-card-actions>
                    </v-card>
                  </v-dialog>
                </v-row>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import axios from 'axios'
import { mapGetters, mapMutations } from 'vuex'

export default {
  data () {
    return {
      post: [],
      current_user: [],
      dialog: false,
      comments: [],
      isParticipated: '',
      participated_users: [],
    }
  },
  methods: {
    participate: function() {
      const participate_url = 'http://localhost:3000/participate'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('user_id', this.current_user.id);
      params.append('post_id', this.$route.params.id);
      axios.post(participate_url, params).then(
        this.isParticipated = true
      )
    },
    unparticipate: function() {
      const unparticipate_url = 'http://localhost:3000/unparticipate'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('user_id', this.current_user.id);
      params.append('post_id', this.$route.params.id);
      axios.post(unparticipate_url, params).then(
        this.isParticipated = false
      )
    },
    comment: function() {
      const comment_url = 'http://localhost:3000/comment/' + this.current_user.id
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('content', this.content);
      params.append('post_id', this.$route.params.id);
      axios.post(comment_url, params).then(
        this.dialog = false
      )
    },
  },
  created() {
    // 投稿情報の取得
    const post_url = 'http://localhost:3000/posts/' + this.$route.params.id
    axios.get(post_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.post = response.data
      })

    // 参加者すべての取得
    const participated_user_url = 'http://localhost:3000/api/v1/get_participated_users/' + this.$route.params.id
    axios.get(participated_user_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.participated_users = response.data
      })

    const get_comment_url = 'http://localhost:3000/api/v1/get_comment/' + this.$route.params.id
    axios.get(get_comment_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.comments = response.data
      })

    // 自分が参加しているかの取得
    const is_participated_url = 'http://localhost:3000/isparticipated/' + this.$route.params.id
    axios.get(is_participated_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": this.$store.state.accessToken,
        "client": this.$store.state.client,
        "uid": this.$store.state.uid,
        // "access-token": localStorage.getItem('access-token'),
        // "client": localStorage.getItem('client'),
        // "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.isParticipated = response.data
      })

    // 現在のユーザー取得
    const current_user_url = 'http://localhost:3000/api/v1/show'
    axios.get(current_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": this.$store.state.accessToken,
        "client": this.$store.state.client,
        "uid": this.$store.state.uid,
        // "access-token": localStorage.getItem('access-token'),
        // "client": localStorage.getItem('client'),
        // "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.current_user = response.data.data
      })
  }
}
</script>
