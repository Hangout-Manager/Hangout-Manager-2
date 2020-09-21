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
        <v-col cols="4">
          <router-link to="/">
            <v-img
              src="images/logo_hangout.png"
              height="90"
              width="150"
              >
            </v-img>
          </router-link>
        </v-col>
        <v-col cols="5"></v-col>
        <v-col cols="2">
          <v-row>
            <v-col>
              <div class="text-center">
                <v-menu offset-y>
                  <template v-slot:activator="{ on, attrs }">
                    <v-icon
                      color="primary"
                      dark
                      text
                      size="50"
                      v-bind="attrs"
                      v-on="on"
                      >mdi-menu</v-icon>
                  </template>
                  <v-list shaped width="500">
                    <v-subheader>Menu</v-subheader>
                    <v-list-item-group v-model="item" color="primary">
                    <v-list-item
                      v-for="(item, index) in items"
                      :key="index"
                      :to="item.click"
                      >
                      <v-list-item-icon>
                        <v-icon v-text="item.icon"></v-icon>
                      </v-list-item-icon>
                      <v-list-item-content>
                        <v-list-item-title v-text="item.title"></v-list-item-title>
                      </v-list-item-content>
                    </v-list-item>
                    <v-list-item @click="signOut">
                      <v-list-item-icon>
                        <v-icon>mdi-clock</v-icon>
                      </v-list-item-icon>
                      <v-list-item-content>
                        <v-list-item-title>ログアウト</v-list-item-title>
                      </v-list-item-content>
                    </v-list-item>
                    </v-list-item-group>
                  </v-list>
                </v-menu>
              </div>
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
  data (){
    return {
      items: [
        { title: 'マイページ', click: '/MyPage', icon: 'mdi-account' },
        { title: 'ユーザー一覧', click: '/Users', icon: 'mdi-account-multiple' },
        { title: '新規プロフィール登録', click: '/RegisterProfile', icon: 'mdi-flag' },
      ]
    }
  },
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
