<template>
  <div>
 <template>
  <v-row justify="center">
    <v-dialog v-model="show" max-width="600px">
      <v-card>
        <v-card-title>
          <span class="headline">ログイン</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-text-field label="メールアドレス" v-model="email" required></v-text-field>
            <v-text-field label="パスワード" v-model="password" type="password" required></v-text-field>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn color="blue darken-1" dark @click="show = false">閉じる</v-btn>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" dark @click="signIn">ログイン</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template> 
  </div>
</template>

<script>
import axios from 'axios'
export default {
  name: 'SignUp',
  data () {
    return {
      show: false,
      email: '',
      password: '',
    }
  },
  methods: {
    open () {
      this.show = true
    },
    signIn: function() {
      const url = 'http://localhost:3000/api/auth/sign_in'
      var params = new URLSearchParams();
      params.append('email', this.email);
      params.append('password', this.password);
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      axios.post(url, params).then(
        (response) => {
          this.$store.commit('setAccessToken', response.headers['access-token'])
          this.$store.commit('setClient', response.headers['client'])
          this.$store.commit('setUid', response.headers['uid'])
          this.$store.commit('setTokenType', response.headers['token-type'])
          localStorage.setItem('access-token', response.headers['access-token'])
          localStorage.setItem('client', response.headers['client'])
          localStorage.setItem('uid', response.headers['uid'])
          localStorage.setItem('token-type', response.headers['token-type'])
          this.$router.push('MyPage')
        },
        (error) => {
          return error
        }
        )
      this.show = false
    }
  }
}
</script>


