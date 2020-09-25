<template>
  <div>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <h1>{{ user.name }}のプロフィール登録</h1>
        <hr>
      </v-col>
      <v-col cols="1"></v-col>
    </v-row>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <v-card>
          <v-row >
            <v-col cols="4"></v-col>
            <v-col cols="4">
            <v-slider
              v-model="age"
              :rules="rules.age"
              color="orange"
              label="年齢"
              min="0"
              max="120"
              thumb-label="always"
            ></v-slider>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row >
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <v-select
                v-model.number="sex"
                :items="sex_name"
                :menu-props="{ top: true, offsetY: true }"
                label="性別"
                outlined
                item-text="name"
                item-value="id"
                ></v-select>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row >
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <v-select
                v-model.number="place"
                :items="prefectures"
                :menu-props="{ top: true, offsetY: true }"
                label="住んでる場所"
                outlined
                item-text="name"
                item-value="id"
                ></v-select>
            </v-col>
            <v-col cols="4"></v-col>
          </v-row>
          <v-row>
            <v-col cols="4"></v-col>
            <v-col cols="4">
              <v-btn large color="primary" @click="register">登録</v-btn>
            </v-col> 
            <v-col cols="4"></v-col>
          </v-row>
        </v-card>
      </v-col>
      <v-col cols="1"></v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios'

export default {
  data () {
    return {
      user: [],
      age: [],
      rules: {
        age: [
          val => val < 100 || `I don't believe you!`,
          ],
      },
      sex: [],
      sex_name: [
        { name: "男", id: 1 },
        { name: "女", id: 2 },
        { name: "その他", id: 3 },
      ],
      place: [],
      prefectures: [
        { name: "北海道", id: 1 },
        { name: "青森県", id: 2 },
        { name: "岩手県", id: 3 },
        { name: "宮城県", id: 4 },
        { name: "秋田県", id: 5 },
        { name: "山形県", id: 6 },
        { name: "福島県", id: 7 },
        { name: "茨城県", id: 8 },
        { name: "栃木県", id: 9 },
        { name: "群馬県", id: 10 },
        { name: "埼玉県", id: 11 },
        { name: "千葉県", id: 12 },
        { name: "東京都", id: 13 },
        { name: "神奈川県", id: 14 },
        { name: "新潟県", id: 15 },
        { name: "富山県", id: 16 },
        { name: "石川県", id: 17 },
        { name: "福井県", id: 18 },
        { name: "山梨県", id: 19 },
        { name: "長野県", id: 20 },
        { name: "岐阜県", id: 21 },
        { name: "静岡県", id: 22 },
        { name: "愛知県", id: 23 },
        { name: "三重県", id: 24 },
        { name: "滋賀県", id: 25 },
        { name: "京都府", id: 26 },
        { name: "大阪府", id: 27 },
        { name: "兵庫県", id: 28 },
        { name: "奈良県", id: 29 },
        { name: "和歌山県", id: 30 },
        { name: "鳥取県", id: 31 },
        { name: "島根県", id: 32 },
        { name: "岡山県", id: 33 },
        { name: "広島県", id: 34 },
        { name: "山口県", id: 35 },
        { name: "徳島県", id: 36 },
        { name: "香川県", id: 37 },
        { name: "愛媛県", id: 38 },
        { name: "高知県", id: 39 },
        { name: "福岡県", id: 40 },
        { name: "佐賀県", id: 41 },
        { name: "長崎県", id: 42 },
        { name: "熊本県", id: 43 },
        { name: "大分県", id: 44 },
        { name: "宮崎県", id: 45 },
        { name: "鹿児島県", id: 46 },
        { name: "沖縄県", id: 47 },
      ]
    }
  },
  created() {
    const show_url = 'http://localhost:3000/api/v1/show'
    axios.get(show_url, {
      headers: { 
        "Content-Type": "application/json", 
        "access-token": localStorage.getItem('access-token'),
        "client": localStorage.getItem('client'),
        "uid": localStorage.getItem('uid'),
      }
    }
    )
      .then(response => {
        this.user = response.data.data
      })
  },
  methods: {
    register: function() {
      const register_url = 'http://localhost:3000/user_profiles'
      axios.defaults.headers.common['Content-Type'] = 'application/json';
      var params = new URLSearchParams();
      params.append('age', this.age);
      params.append('sex_id', this.sex);
      params.append('place_id', this.place);
      params.append('user_id', this.user.id);
      axios.post(register_url, params).then(
        () => {
          this.$router.push('RegisterTrend')
        },
        (error) => {
          return error
        })
    }
  }
}
</script>
