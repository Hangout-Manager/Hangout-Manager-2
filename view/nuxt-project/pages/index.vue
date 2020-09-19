<template>
  <div>
    <v-container>
      <v-row justify="center" align-content="center">
        <v-col cols="12">
        <v-card
          height="600"
          color="#B0BEC5"
          raised
          >
          <v-row justify="center" align-content="center">
            <v-col cols="4">
              <v-img
                src="images/logo_hangout.png"
                class="pad50"
                >
              </v-img>
            </v-col>
            <v-col cols="1"></v-col>
            <v-col cols="4">
              <v-card
                class="pad90"
                >
                <v-card-title>ログイン</v-card-title>
                <v-card-text>
                  <v-text-field outlined label="メールアドレス" v-model="email" required></v-text-field>
                  <v-text-field outlined label="パスワード" v-model="password" type="password" required></v-text-field>
                  <v-btn color="#1976D2" dark @click="signIn">ログイン</v-btn>
                </v-card-text>
              </v-card>
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
  name: "Welcome",
  data () {
    return {
      email: '',
      password: '',
    }
  },
  methods: {
    open () {
    },
    signIn: function() {
      const url = 'http://localhost:3000/api/auth/sign_in'
      var params = new URLSearchParams();
      params.append('email', this.email);
      params.append('password', this.password);
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      axios.post(url, params).then(
        (response) => {
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
    }
  }
}
</script>
<style>
.bg {
  background-image: url("../assets/welcome.png");
  background-size: cover;
}
.pad50 {
  margin-top: 50px;
}
.pad90 {
  margin-top: 90px;
}
</style>
