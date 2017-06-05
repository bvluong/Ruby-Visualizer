<template>
  <div id="app">
    <p>{{ message }}</p>
    <CodeInput></CodeInput>
  </div>
</template>

<script>
import CodeInput from '../components/code_input'

export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  },
  components: { CodeInput }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
