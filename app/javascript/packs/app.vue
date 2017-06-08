<template>
  <div id="app">
    <Banner></Banner>
    <CodeInput></CodeInput>
    <Foot></Foot>
  </div>
</template>

<script>
import CodeInput from '../components/code_input'
import Banner from '../components/banner'
import Foot from '../components/foot'

export default {
  components: { CodeInput, Banner, Foot }
}
</script>
