<template>
  <div>
 <template>
  <v-row justify="center">
    <v-dialog v-model="show" max-width="600px">
      <v-card>
        <v-card-title>
          <span class="headline">新規登録</span>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-text-field label="名前" v-model="name" required></v-text-field>
            <v-text-field label="メールアドレス" v-model="email" required></v-text-field>
            <v-text-field label="パスワード" v-model="password" type="password" required></v-text-field>
            <v-text-field label="パスワード確認" v-model="password_confirmation" type="password" required></v-text-field>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-btn color="blue darken-1" dark @click="show=false">閉じる</v-btn>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" dark @click="signUp">新規登録</v-btn>
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
  name: 'signUp',
  data () {
    return {
      show: false,
      name: '',
      email: '',
      password: '',
      password_confirmation: '',
    }
  },
  methods: {
    open () {
      this.show = true
    },
    signUp: function() {
      const url = 'http://localhost:3000/api/auth'
      var params = new URLSearchParams();
      params.append('name', this.name);
      params.append('email', this.email);
      params.append('password', this.password);
      params.append('password_confirmation', this.password_confirmation);
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      axios.post(url, params).then(
        (response) => {
          localStorage.setItem('access-token', response.headers['access-token'])
          localStorage.setItem('client', response.headers['client'])
          localStorage.setItem('uid', response.headers['uid'])
          localStorage.setItem('token-type', response.headers['token-type'])
          this.$router.push('RegisterProfile')
          this.show = false
    },
      )
    }
  }
}
</script>
