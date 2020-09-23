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
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-card-text>{{ post.content }}</v-card-text>
              </v-col>
            </v-row>
            <v-row>
              <v-col>
                <v-chip class="ma-2" label>
                  {{ post.tag }}
                </v-chip>
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
    }
  },
  created() {
    const post_url = 'http://localhost:3000/posts/' + this.$route.params.id
    axios.get(post_url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.post = response.data
      })
  }
}
</script>
