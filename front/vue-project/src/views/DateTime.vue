<template>
  <div>
    <v-row justify="center">
      <v-date-picker v-model="pickerDate"></v-date-picker>
    </v-row>
    {{ pickerDate }}
      <v-row justify="center">
        <v-time-picker v-model="pickerTime"></v-time-picker>
      </v-row>
    {{ pickerTime }}
    {{ today }}
    <p v-if="pickerDate - today">True</p>
    <p v-else>False</p>

  </div>
</template>


<script>
// import moment from 'moment'
  export default {
    data () {
      return {
        pickerDate: new Date().toISOString().substr(0, 10),
        pickerTime: null,
        today: new Date()
      }
    },
  }
</script>
