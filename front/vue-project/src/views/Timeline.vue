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
                <v-col cols="5" v-for="post in posts" :key="post.id">
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
                <v-col cols="5" v-for="post in posts" :key="post.id">
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
                <v-col cols="5" v-for="post in posts" :key="post.id">
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
import hangouts from '@/components/hangouts.vue'

export default {
  data () {
    return {
      tabs: null,
      posts: [],
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
  }
}
</script>
