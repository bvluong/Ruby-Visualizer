<template>
  <div id="app">
    <Header></Header>
    <CodeInput></CodeInput>
  </div>
</template>

<script>
import CodeInput from '../components/code_input'
import Header from '../components/header'

export default {
  components: { CodeInput, Header }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}

#app{
  background-color: blue;
}
</style>
