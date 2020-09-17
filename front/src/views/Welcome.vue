<template>
  <div>
    <br><br><br>
    <h1>Welcome</h1>
    <br>
    <div class="text-center">
      <v-btn rounded color="#033" dark @click="onClickSignUp">Sign Up</v-btn>
      <signup ref="signup"/> 
    </div>
    <br>
    <div class="text-center">
      <v-btn rounded color="#033" dark @click="onClickSignIn">Sign In</v-btn>
      <signin ref="signin"/> 
    </div>
  </div>
</template>

<script>
import Signup from '../components/signup.vue'
import Signin from '../components/signin.vue'
export default {
  name: "Welcome",
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
    }
  }
}
</script>

