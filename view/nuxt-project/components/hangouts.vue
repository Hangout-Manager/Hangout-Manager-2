<template>
  <v-hover v-slot:default="{ hover }">
    <v-card
      :elevation="hover ? 12 : 2"
      :class="{ 'on-hover': hover }"
      :to="{
             name:'Hangouts-id',
             params:{
             id:id
             }
             }"
      >
      <v-chip v-if="label_id==1" class="ma-2" dark color="primary">募集中</v-chip>
      <v-chip v-if="label_id==2" class="ma-2" dark color="green">募集締め切り</v-chip>
      <v-chip v-if="label_id==3" class="ma-2" dark color="red">終了</v-chip>
      <v-card-title>{{ title }}</v-card-title>
      <v-card-text>{{ content }}</v-card-text>
      <v-chip
        class="ma-2"
        label
        >
        {{ tag }}
      </v-chip>
    </v-card>
  </v-hover>
</template>

<script>
export default {
  name: 'SakeInformation',
  props: {
    id: String,
    label_id: String,
    title: String,
    content: String,
    tag: String,
  }, 
}
</script>
