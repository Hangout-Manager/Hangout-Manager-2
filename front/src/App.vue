<template>
  <v-app id="app">
    <v-app-bar
      app
      color="#E0E0E0"
      dense
      dark
      height="120"
      >
      <v-row>
        <v-col cols="5">
          <router-link to="/">
            <v-img
              src="../src/assets/logo_hangout.png"
              height="90"
              width="150"
              >
            </v-img>
          </router-link>
        </v-col>
        <v-col cols="7"></v-col>
      </v-row>
      <v-row>
        <v-col cols="5"></v-col>
        <v-col>
          <v-btn color="#FF6D00" dark x-large to="/MyPage">マイページ</v-btn>
        </v-col>
        <v-col>
          <v-btn color="#AD1457" dark x-large @click="onClickSignUp">新規登録</v-btn>
          <signup ref="signup"/> 
        </v-col>
        <v-col>
          <v-btn color="#1976D2" dark x-large @click="onClickSignIn">ログイン</v-btn>
          <signin ref="signin"/> 
        </v-col>
        <v-col>
          <v-btn color="#78909C" dark x-large @click="signOut">ログアウト</v-btn>
          <signin ref="signin"/> 
        </v-col>
      </v-row>
    </v-app-bar>
    <v-main>
      <router-view/>
    </v-main>
  </v-app>
</template>

<script>
import Signup from '../src/components/signup.vue'
import Signin from '../src/components/signin.vue'
import axios from 'axios'

export default {
  name: 'App',
  components: {
    Signup,
    Signin
  },
  methods: {
    onClickSignUp() {
      console.log('onClickSignUp')
      this.$refs.signup.open();
    },
    onClickSignIn() {
      this.$refs.signin.open();
    },
    signOut: function() {
      const url = process.env.VUE_APP_URL + '/api/auth/sign_out'
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
  }
};
</script>

<style lang="scss">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}

#nav {
  padding: 30px;

  a {
    font-weight: bold;
    color: #2c3e50;

    &.router-link-exact-active {
      color: #42b983;
    }
  }
}
</style>
