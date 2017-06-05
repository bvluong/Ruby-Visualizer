<template>
  <div id="app">
    <Banner></Banner>
    <CodeInput></CodeInput>
  </div>
</template>

<script>
import CodeInput from '../components/code_input'
import Banner from '../components/banner'

export default {
  components: { CodeInput, Banner }
}
</script>
