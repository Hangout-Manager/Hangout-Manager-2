<template>
  <div>
    <v-container>
      <v-row>
        <v-col>
          <h1>{{ this.$store.state.accessToken }}</h1>
          <h1>{{ this.$store.state.client }}</h1>
          <h1>{{ this.$store.state.uid }}</h1>
        </v-col>
        <v-col v-for="user in users" :key="user.id" cols="3">
          <v-hover v-slot:default="{ hover }">
            <v-card
              class="d-inline-block mx-auto"
              width="400"
              height="200"
              :elevation="hover ? 12 : 2"
              :class="{ 'on-hover': hover }"
              :to="{
                     name:'user-id',
                     params:{
                     id:user.id
                     }
                     }"
              >
              <v-card-title>{{ user.name }}</v-card-title>
              <v-card-text>{{ user.email }}</v-card-text>
            </v-card>
          </v-hover>
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
      headers: [
        {
          text: '名前',
          align: 'start',
          sortable: false,
          value: 'name',
        },
        { text: 'メールアドレス', value: 'email' },
      ],
      users: [],
    }
  },
  created() {
    const url = 'http://localhost:3000/api/v1/index'
    axios.get(url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        this.users = response.data.data
      })
  }
}
</script>
