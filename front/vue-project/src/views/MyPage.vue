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
                <h1 style="text-align:left">ようこそ{{ user.name }}さん</h1>
                <hr>
                <v-row>
                  <v-col cols="8">
                    <v-card>
                      <v-row justify=center>
                        <v-col cols="3" justify="center" align-content="center">
                          <v-img
                            src="@/assets/noImage.jpg"
                            class="padleft"
                            >
                          </v-img>
                        </v-col>
                            <v-col cols="9">
                              <v-list>
                                <v-list-item>
                              <v-list-item-content>メールアドレス</v-list-item-content>
                              <v-list-item-content class="align-end">{{ user.email }}</v-list-item-content>
                            </v-list-item>
                            <v-list-item>
                              <v-list-item-content>出身地</v-list-item-content>
                              <v-list-item-content class="align-end">{{ profile.place }}</v-list-item-content>
                            </v-list-item>
                            <v-list-item>
                              <v-list-item-content>年齢</v-list-item-content>
                              <v-list-item-content class="align-end">{{ profile.age }}</v-list-item-content>
                            </v-list-item>
                            <v-list-item>
                              <v-list-item-content>性別</v-list-item-content>
                              <v-list-item-content class="align-end">{{ profile.sex }}</v-list-item-content>
                            </v-list-item>
                            <v-list-item>
                              <v-btn color="#FF6D00" block dark to='/EditProfile'>プロフィールの編集</v-btn>
                            </v-list-item>
                          </v-list>
                        </v-col>
                      </v-row>
                    </v-card>
                  </v-col>
                  <v-col>
                    <v-row>
                      <v-col>
                        <v-card
                          :to="{name: 'MyFollowings'}"
                          >
                          <v-card-text>フォロー</v-card-text>
                          <v-card-title>{{ followings.length }}</v-card-title>
                        </v-card>
                      </v-col>
                    </v-row>
                    <v-row>
                      <v-col>
                        <v-card
                          :to="{name: 'MyFollowers'}"
                          >
                          <v-card-text>フォロワー</v-card-text>
                          <v-card-title>{{ followers.length }}</v-card-title>
                        </v-card>
                      </v-col>
                    </v-row>
                  </v-col>
                </v-row>
                <v-row>
                  <v-col>
                    <v-btn color="#AD1457" dark block @click="onClickPost">あそびを投稿する</v-btn>
                    <post ref="post"/> 
                  </v-col>
                  <v-col>
                    <v-btn color="#AD1457" dark block :to="{name: 'Question'}">あそびをレコメンドする</v-btn>
                  </v-col>
                  <v-col>
                  <v-btn color="#AD1457" dark block 
                         :to="{
                               name: 'RecommendUser',
                               params:{
                               id:this.user.id
                               }
                               }"
                         >友達レコメンド</v-btn>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="5">
                <v-card>
                  <v-card-title class="subheading font-weight-bold">{{ user.name }}が予定しているあそび</v-card-title>
                  <v-row justify="center" align-content="center">
                    <v-col cols="12" v-for="post in posts" :key="post.id">
                      <hangouts
                        :id="post.id"
                        :label_id="post.label_id"
                        :title="post.title"
                        :content="post.content"
                        :tag="post.tag"
                        />
                    </v-col>
                  </v-row>
                </v-card>
              </v-col>
              <v-col>
                <v-card>
                  <v-card-title class="subheading font-weight-bold">{{ user.name }}が参加予定のあそび</v-card-title>
                  <v-row justify="center" align-content="center">
                    <v-col cols="12" v-for="p in participations" :key="p.id">
                      <hangouts
                        :id="p.id"
                        :label_id="p.label_id"
                        :title="p.title"
                        :content="p.content"
                        :tag="p.tag"
                        />
                    </v-col>
                  </v-row>
                </v-card>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import Post from '@/components/Post.vue'
import hangouts from '@/components/hangouts.vue'
import axios from 'axios'

export default {
  data () {
    return {
      user: [],
      profile: [],
      followings: [],
      followers: [],
      posts: [],
      long_trend: [],
      participations: []
    }
  },
  components: {
    Post,
    hangouts
  },
  methods: {
    open () {
    },
    onClickPost() {
      this.$refs.post.open();
    },
    signOut: function() {
      const url = 'http://localhost:3000/api/auth/sign_out'
      axios.delete(url, {
        headers: { 
          "Content-Type": "application/json", 
          "access-token": localStorage.getItem('access-token'),
          "client": localStorage.getItem('client'),
          "uid": localStorage.getItem('uid')
        }
      }).then(
        this.$router.push('/'),
        localStorage.removeItem('access-token'),
        localStorage.removeItem('client'),
        localStorage.removeItem('uid')
      )
    }
  },
  created() {
    const user_url = 'http://localhost:3000/api/v1/show'
    axios.get(user_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.user = response.data.data
      })
    const profile_url = 'http://localhost:3000/api/v1/profile'
    axios.get(profile_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.profile = response.data.data
      })
    const following_url = 'http://localhost:3000/api/v1/current_get_followings'
    axios.get(following_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.followings = response.data.data
      })
    const followers_url = 'http://localhost:3000/api/v1/current_get_followers'
    axios.get(followers_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.followers = response.data.data
      })
    const posts_url = 'http://localhost:3000/api/v1/current_get_posts'
    axios.get(posts_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.posts = response.data.data
      })
    const participation_url = 'http://localhost:3000/api/v1/current_get_participations'
    axios.get(participation_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.participations = response.data
      })
    const long_trend_url = 'http://localhost:3000/api/v1/current_get_long_trend'
    axios.get(long_trend_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid')
      }
    })
      .then(response => {
        this.long_trend = response.data.data
      })
  }
}
</script>
<style>
.padleft {
  margin-left: 15px;
}
</style>
