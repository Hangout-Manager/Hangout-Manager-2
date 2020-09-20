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
        <v-col cols="1"></v-col>
        <v-col cols="2">
          <router-link to="/">
            <v-img
              src="images/logo_hangout.png"
              height="90"
              width="150"
              >
            </v-img>
          </router-link>
        </v-col>
        <v-col cols="4"></v-col>
        <v-col cols="4">
          <v-row>
            <v-col cols="2">
              <v-btn color="#FF6D00" dark x-large block text to="/RegisterProfile">Profile</v-btn>
            </v-col>
            <v-col cols="2">
              <v-btn color="#FF6D00" dark x-large block text to="/MyPage">MyPage</v-btn>
            </v-col>
            <v-col cols="2">
              <v-btn color="#FF6D00" dark x-large block text to="/Users">Users</v-btn>
            </v-col>
            <v-col cols="2">
              <v-btn color="#AD1457" dark x-large block text @click="onClickSignUp">Sign UP</v-btn>
              <signup ref="signup"/> 
            </v-col>
            <v-col cols="2">
              <v-btn color="#1976D2" dark x-large block text @click="onClickSignIn">Sign In</v-btn>
              <signin ref="signin"/> 
            </v-col>
            <v-col cols="2">
              <v-btn color="#78909C" dark x-large block text @click="signOut">Sign Out</v-btn>
            </v-col>
          </v-row>
          <v-col cols="1"></v-col>
        </v-col>
      </v-row>
    </v-app-bar>
    <v-main style="background-color:#90CAF9">
      <nuxt />
    </v-main>
  </v-app>
</template>

<script>
import Signup from '../components/signup.vue'
import Signin from '../components/signin.vue'
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
  }
};
</script>
