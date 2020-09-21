<template>
  <div>
    <v-stepper v-model="e1">

      <v-stepper-items
        >
        <v-stepper-content
          v-for="i in steps"
          :key="i"
          :step="i"
          >
          <v-card
            class="mb-12"
            color="grey lighten-1"
            height="200px"
            >
            {{ i }}
            {{ hangouts[i-1].name }}
          </v-card>

          <v-btn
            color="primary"
            @click="nextStep(i), pushYes(i)"
            >
            はい
          </v-btn>

            <v-btn
              color="primary"
              @click="nextStep(i)"
              >
              いいえ
            </v-btn>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>
    <p>
      {{ hangouts[yes_list[0]] }}
      {{ hangouts[yes_list[1]] }}
      {{ hangouts[yes_list[2]] }}
      {{ hangouts[yes_list[3]] }}
      {{ hangouts[yes_list[4]] }}
    </p>
    <v-row justify="center">
      <v-dialog
        v-model="dialog"
        persistent
        max-width="500"
        >
        <v-card>
          <v-card-title class="headline">マイページに飛ぶ</v-card-title>

          <v-card-text>
            {{ hangouts[yes_list[0]] }}
            {{ hangouts[yes_list[1]] }}
            {{ hangouts[yes_list[2]] }}
            {{ hangouts[yes_list[3]] }}
            {{ hangouts[yes_list[4]] }}
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn
              color="green darken-1"
              text
              @click="dialog = false, yes_list = [], count = 0, e1 = 1"
              >最初からやり直す</v-btn>

              <v-btn
                color="green darken-1"
                text
                to="/MyPage"
                >
                はい
              </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
  </div>
</template>
<script>
import axios from 'axios'

export default {
  data () {
    return {
      e1: 1,
      count: 0,
      steps: 1,
      yes_list: [],
      dialog: false,
      hangouts: [{}]
    }
  },
  watch: {
    steps (val) {
      if (this.e1 > val) {
        this.e1 = val
      }
    },
  },
  methods: {
    test(val) {
      console.log(Object.keys(val))
    },
    nextStep (n) {
      if (n === this.hangouts.length) {
        this.e1 = 1
      } else {
        this.e1 = n + 1
      }
    },
    pushYes (n) {
      this.count += 1
      this.yes_list += n
      if (this.count == 5){
        this.dialog = true
      }
    }
  },
  mounted() {
    const url = 'http://localhost:3000/hangouts'
    axios.get(url, {
      headers: { 
        "Content-Type": "application/json", 
      }
    })
      .then(response => {
        console.log(response.data)
        this.hangouts = response.data;
        this.steps = this.hangouts.length
      })
  }
}
</script>
