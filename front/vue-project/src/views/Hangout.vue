<template>
  <div>
    <v-container>
      <v-row>
        <v-col cols="1"></v-col>
        <v-col cols="10">
          <v-card>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <v-chip v-if="post.label_id==1" class="ma-2" dark color="primary">募集中</v-chip>
                <v-chip v-if="post.label_id==2" class="ma-2" dark color="green">募集締め切り</v-chip>
                <v-chip v-if="post.label_id==3" class="ma-2" dark color="red">終了</v-chip>
                <v-chip class="ma-2" label>
                  {{ post.tag }}
                </v-chip>
                <v-card>
                  <br>
                    <v-card-title style="font-size:3em">{{ post.title }}</v-card-title>
                    <br>
                    <v-card-text style="font-size:2em">{{ post.content }}</v-card-text>
                    <br>
                    <v-card-text style="font-size:1em">{{ post.start_date }}</v-card-text>
                    <v-card-text style="font-size:1em">開始時間：{{ start_time }}</v-card-text>
                    <v-card-text style="font-size:1em">想定時間：{{ post.estimate_time }}時間</v-card-text>
                </v-card>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="10">
                <div v-if="this.current_user.id == this.post_user.id">
                    <div v-if="this.post.label_id==1">
                      <v-row>
                        <v-col cols="6">
                          <v-btn color="green" block dark @click="update2">募集締め切りにする</v-btn>
                        </v-col>
                        <v-col cols="6">
                          <v-btn color="red" block dark @click="update3">終了にする</v-btn>
                        </v-col>
                      </v-row>
                    </div>
                    <div v-if="this.post.label_id==2">
                      <v-row>
                        <v-col cols="6">
                          <v-btn color="blue" block dark @click="update1">募集中にする</v-btn>
                        </v-col>
                        <v-col cols="6">
                          <v-btn color="red" block dark @click="update3">終了にする</v-btn>
                        </v-col>
                      </v-row>
                    </div>
                    <div v-if="this.post.label_id==3">
                      <v-row>
                        <v-col cols="6">
                          <v-btn color="blue" block dark @click="update1">募集中にする</v-btn>
                        </v-col>
                        <v-col cols="6">
                          <v-btn color="green" block dark @click="update2">募集締め切りにする</v-btn>
                        </v-col>
                      </v-row>
                    </div>
                </div>
                <div v-else>
                  <v-btn v-if="isParticipated" color="#AD1457" block dark @click="unparticipate">参加を取り消す</v-btn>
                  <v-btn v-else color="#1976D2" block dark @click="participate">参加する</v-btn>
                </div>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="3">
                <v-card>
                  <v-card-title>主催者</v-card-title>
                  <v-row>
                    <v-col cols="1"></v-col>
                    <v-col>
                      <v-btn color="black" dark block text :to="{name:'user', params:{id:post_user.id}}">{{ post_user.name }}</v-btn>
                    </v-col>
                    <v-col cols="1"></v-col>
                  </v-row>
                </v-card>
                <v-card>
                  <v-card-title>参加者 ({{ this.participated_users.length }}/{{ post.upper_number }})</v-card-title>
                  <v-row v-for="user in participated_users" :key="user.id">
                    <v-col cols="1"></v-col>
                    <v-col>
                      <v-btn color="black" dark block text :to="{name:'user', params:{id:user.id}}">{{ user.name }}</v-btn>
                    </v-col>
                    <v-col cols="1"></v-col>
                  </v-row>
                </v-card>
              </v-col>
              <v-col cols="7">
                <v-card>
                  <v-card-title>コメント</v-card-title>
                  <v-row v-for="(comment, i) in comments" :key="i">
                    <v-col cols="1"></v-col>
                    <v-col cols="2">
                      <v-btn color="black" dark block text :to="{name:'user', params:{id:users[i].id}}">{{ users[i].name }}</v-btn>
                    </v-col>
                    <v-col cols="1">
                      <v-avatar color="indigo">
                        <v-icon dark align-content="center">mdi-account-circle</v-icon>
                      </v-avatar>
                    </v-col>
                    <v-col cols="3">
                      <p class="my-parts">{{ comment.content }}</p>
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col cols="1"></v-col>
                    <v-col>
                      <v-btn color="#AD1457" dark block @click="dialog=true">コメント</v-btn>
                    </v-col>
                    <v-col cols="1"></v-col>
                  </v-row>
                </v-card>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col>
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

export default {
  data () {
    return {
      post: [],
      post_user: [],
      current_user: [],
      dialog: false,
      comments: [],
      start_time: [],
      users: [],
      isParticipated: '',
      participated_users: [],
    }
  },
  methods: {
    update1: function() {
      const update_url = 'http://localhost:3000/posts/' + this.$route.params.id
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('label_id', 1);
      axios.put(update_url, params).then(
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      )
    },
    update2: function() {
      const update_url = 'http://localhost:3000/posts/' + this.$route.params.id
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('label_id', 2);
      axios.put(update_url, params).then(
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      )
    },
    update3: function() {
      const update_url = 'http://localhost:3000/posts/' + this.$route.params.id
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('label_id', 3);
      axios.put(update_url, params).then(
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      )
    },
    participate: function() {
      const participate_url = 'http://localhost:3000/participate'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('user_id', this.current_user.id);
      params.append('post_id', this.$route.params.id);
      axios.post(participate_url, params).then(
        this.isParticipated = true,
        this.$router.go({path: this.$router.currentRoute.path, force: true})
      )
    },
    unparticipate: function() {
      const unparticipate_url = 'http://localhost:3000/unparticipate'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('user_id', this.current_user.id);
      params.append('post_id', this.$route.params.id);
      axios.post(unparticipate_url, params).then(
        this.isParticipated = false,
          this.$router.push('/MyPage')
      )
    },
    comment: function() {
      const comment_url = 'http://localhost:3000/comment/' + this.current_user.id
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('content', this.content);
      params.append('post_id', this.$route.params.id);
      axios.post(comment_url, params).then(
        this.dialog = false,
        this.$router.go({path: this.$router.currentRoute.path, force: true})
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
    
    const start_time_url = 'http://localhost:3000/api/v1/get_post_start_time/' + this.$route.params.id
    axios.get(start_time_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.start_time = response.data
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
        this.comments = response.data[0].comments
        this.users = response.data[0].users
      })

    // 自分が参加しているかの取得
    const is_participated_url = 'http://localhost:3000/isparticipated/' + this.$route.params.id
    axios.get(is_participated_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.isParticipated = response.data
      })

    const post_user_url = 'http://localhost:3000/api/v1/get_post_user/' + this.$route.params.id
    axios.get(post_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.post_user = response.data
      })

    // 現在のユーザー取得
    const current_user_url = 'http://localhost:3000/api/v1/show'
    axios.get(current_user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.current_user = response.data.data
      })
  }
}
</script>
<style>
.my-parts {
  display: inline-block;
  width: 300px;
  max-width: 100%;
  background: #FFCC80;
  border: 2px solid #F57C00;
  border-radius: 0px;
  padding: .8em;
  position: relative;
  text-align: left;
}
.my-parts > :last-child {
  margin-bottom: 0;
}
.my-parts::before,
.my-parts::after {
  content: "";
  position: absolute;
  top: 50%;
  right: 100%;
}
.my-parts::before {
  margin-top: -12.82px;
  border: 12.82px solid transparent;
  border-right: 12.82px solid #F57C00;
  z-index: 1;
}
.my-parts::after {
  margin-top: -10px;
  border: 10px solid transparent;
  border-right: 10px solid #FFCC80;
  z-index: 2;
}
</style>
