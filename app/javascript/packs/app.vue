<template>
  <div id="app">
    <Banner></Banner>
    <CodeInput></CodeInput>
    <DisplayCode></DisplayCode>
  </div>
</template>

<script>
import CodeInput from '../components/code_input'
import Banner from '../components/banner'
import DisplayCode from '../components/display_code'

export default {
  components: { CodeInput, Banner, DisplayCode }
}
</script>
