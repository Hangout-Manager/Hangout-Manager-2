<template>
  <div>
    <v-row>
      <v-col cols="1"></v-col>
      <v-col cols="10">
        <v-stepper v-model="e1">
          <v-stepper-items
            >
            <v-stepper-content
              v-for="i in steps"
              :key="i"
              :step="i"
              >
              <h1>あなたの普段のことを教えてください</h1>
              <v-row>
                <v-col cols="3"></v-col>
                <v-col cols="6">
                  <v-row justify="center" align-content="center">
                    <v-card
                      class="mb-12"
                      color="#F5F5F5"
                      height="100px"
                      >
                      <v-card-title class="display-1 text--primary">{{ hangouts[i-1].name }}</v-card-title>
                    </v-card>
                  </v-row>
                </v-col>
              </v-row>
              <v-row>
                <v-col>
                  <h2 style="text-align:center">であそぶのは好きですか？</h2>
                </v-col>
              </v-row>
              <v-row>
                <v-col cols="8"></v-col>
              <v-col cols="2">
                <v-btn
                  color="#AD1457"
                  block
                  dark
                  @click="nextStep(i)"
                  >
                  いいえ
                </v-btn>
              </v-col>
                <v-col cols="2">
                  <v-btn
                    color="#1976D2"
                    block
                  dark
                  @click="nextStep(i), pushYes(i)"
                  >
                  はい
                </v-btn>
              </v-col>
            </v-row>
            </v-stepper-content>
          </v-stepper-items>
        </v-stepper>
        <v-row justify="center">
          <v-dialog
            v-model="dialog"
            persistent
            max-width="600"
            >
            <v-card
              >
              <v-card-title class="headline">以下のあそびであなたの好みを診断します</v-card-title>
              <v-card-text v-for="name in target_hangouts_name">
                ・{{ name }}
              </v-card-text>
            <v-card-text>
                ・{{ target_hangouts_agon }}
              </v-card-text>
              <v-card-text>
                ・{{ target_hangouts_alea }}
              </v-card-text>
              <v-card-text>
                ・{{ target_hangouts_mimicry }}
              </v-card-text>
              <v-card-text>
                ・{{ target_hangouts_ilinx }}
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
      </v-col>
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
      hangouts: [{}],
      target_hangouts: []
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
      this.yes_list += (n-1)
      if (this.count == 3){
        this.target_hangouts_name = [this.hangouts[this.yes_list[0]].name, this.hangouts[this.yes_list[1]].name, this.hangouts[this.yes_list[2]].name]
        this.target_hangouts_agon = [this.hangouts[this.yes_list[0]].agon, this.hangouts[this.yes_list[1]].agon, this.hangouts[this.yes_list[2]].agon]
        this.target_hangouts_alea = [this.hangouts[this.yes_list[0]].alea, this.hangouts[this.yes_list[1]].alea, this.hangouts[this.yes_list[2]].alea]
        this.target_hangouts_mimicry = [this.hangouts[this.yes_list[0]].mimicry, this.hangouts[this.yes_list[1]].mimicry, this.hangouts[this.yes_list[2]].mimicry]
        this.target_hangouts_ilinx = [this.hangouts[this.yes_list[0]].ilinx, this.hangouts[this.yes_list[1]].ilinx, this.hangouts[this.yes_list[2]].ilinx]
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
