<template>
  <div id="app">
    <p>{{ message }}</p>
    <editor></editor>
  </div>
</template>

<script>
import Editor from '../editor'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: { Editor }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
