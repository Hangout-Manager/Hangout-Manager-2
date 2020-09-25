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
                <h1 style="text-align:left">{{ user.name }}さん</h1>
                <hr>
                <v-row>
                  <v-col cols="8">
                    <v-card>
                      <v-row justify=center>
                        <v-col cols="3" justify="center">
                          <v-avatar color="indigo" size="120">
                            <v-icon dark size="120">mdi-account-circle</v-icon>
                          </v-avatar>
                        </v-col>
                        <v-col cols="9">
                          <v-list>
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
                              <v-btn v-if="isNotfollow" color="#1976D2" block dark @click="follow">フォロー</v-btn>
                              <v-btn v-else color="#AD1457" block dark @click="unfollow">フォローを外す</v-btn>
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
                          :to="{name:'UserFollowings', params:{user_id:this.user.id}}"
                          >
                          <v-card-text>フォロー</v-card-text>
                          <v-card-title>{{ followings.length }}</v-card-title>
                        </v-card>
                      </v-col>
                    </v-row>
                    <v-row>
                      <v-col>
                        <v-card
                          :to="{name:'UserFollowers', params:{user_id:this.user.id}}"
                          >
                          <v-card-text>フォロワー</v-card-text>
                          <v-card-title>{{ followers.length }}</v-card-title>
                        </v-card>
                      </v-col>
                    </v-row>
                  </v-col>
                </v-row>
              </v-col>
              <v-col cols="1"></v-col>
            </v-row>
            <v-row>
              <v-col cols="1"></v-col>
              <v-col cols="5">
                <v-card>
                  <v-card-title class="subheading font-weight-bold">{{ user.name }}さんが予定しているあそび</v-card-title>
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
                  <v-card-title class="subheading font-weight-bold">{{ user.name }}さんが参加予定のあそび</v-card-title>
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
import axios from 'axios'
import hangouts from '@/components/hangouts.vue'
export default {
  data () {
    return {
      user: [],
      profile: [],
      current_user: [],
      isNotfollow: [],
      followings: [],
      followers: [],
      posts: [],
      participations: []
    }
  },
  components: {
    hangouts
  },
  methods: {
    follow: function() {
      const follow_url = 'http://localhost:3000/follow'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('user_id', this.current_user.id);
      params.append('follow_id', this.user.id);
      axios.post(follow_url, params).then(
        this.isNotfollow = false
      )
    },
    unfollow: function() {
      const unfollow_url = 'http://localhost:3000/unfollow'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('follow_id', this.user.id);
      params.append('user_id', this.current_user.id);
      axios.post(unfollow_url, params).then(
        this.isNotfollow = true
      )
    }
  },
  created() {
    const user_url = `http://localhost:3000/api/v1/get_user/${this.$route.params.id}`
    axios.get(user_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.user = response.data.data.user
        this.profile = response.data.data
      })
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
    const post_url = 'http://localhost:3000/api/v1/get_posts/' + this.$route.params.id
    axios.get(post_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.posts = response.data
      })
    const participation_url = 'http://localhost:3000/api/v1/get_participations/' + this.$route.params.id
    axios.get(participation_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.participations = response.data
      })
    const is_follow_url = 'http://localhost:3000/isfollow/' + this.$route.params.id
    axios.get(is_follow_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    })
      .then(response => {
        this.isNotfollow = response.data.data
      })
    const following_url = 'http://localhost:3000/api/v1/get_followings/' + this.$route.params.id
    axios.get(following_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.followings = response.data.data
      })
    const followers_url = 'http://localhost:3000/api/v1/get_followers/' + this.$route.params.id
    axios.get(followers_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.followers = response.data.data
      })
  }
}
</script>
