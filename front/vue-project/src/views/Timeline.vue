<template>
  <v-row>
    <v-col cols="1"></v-col>
    <v-col>
      <v-card>
        <v-toolbar
          color="#AD1457"
          dark
          flat
          prominent
          >

          <template v-slot:extension>
            <v-tabs
              v-model="tabs"
              centered
              >
              <v-tab
                >
                募集中
              </v-tab>
              <v-tab
                >
                募集締め切り
              </v-tab>
              <v-tab
                >
                終了
              </v-tab>
            </v-tabs>
          </template>
        </v-toolbar>

        <v-tabs-items v-model="tabs">
          <v-tab-item>
            <v-card flat>
              <v-row justify="center" align-content="center">
                <v-col cols="5" v-for="post in posts1" :key="post.id">
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
          </v-tab-item>
          <v-tab-item>
            <v-card flat>
              <v-row justify="center" align-content="center">
                <v-col cols="5" v-for="post in posts2" :key="post.id">
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
          </v-tab-item>
          <v-tab-item>
            <v-card flat>
              <v-row justify="center" align-content="center">
                <v-col cols="5" v-for="post in posts3" :key="post.id">
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
          </v-tab-item>
        </v-tabs-items>
      </v-card>
    </v-col>
    <v-col cols="1"></v-col>
  </v-row>
</template>

<script>
import axios from 'axios'
import hangouts from '../components/hangouts.vue'

export default {
  data () {
    return {
      tabs: null,
      posts: [],
      posts1: [],
      posts2: [],
      posts3: [],
    }
  },
  components: {
    hangouts
  },
  created() {
    const posts_url = 'http://localhost:3000/posts'
    axios.get(posts_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.posts = response.data
      })
    const posts1_url = 'http://localhost:3000/post_label_1'
    axios.get(posts1_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.posts1 = response.data
      })
    const posts2_url = 'http://localhost:3000/post_label_2'
    axios.get(posts2_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.posts2 = response.data
      })
    const posts3_url = 'http://localhost:3000/post_label_3'
    axios.get(posts3_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.posts3 = response.data
      })
  }
}
</script>
