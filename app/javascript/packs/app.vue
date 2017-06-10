<template>
  <div id="app">
    <Banner v-on:updateCode="updateUserInput"></Banner>
    <CodeInput v-on:updateCode="updateUserInput" :sampleCode="sampleCode"></CodeInput>
    <Foot></Foot>
  </div>
</template>

<script>
import CodeInput from '../components/code_input'
import Banner from '../components/banner'
import Foot from '../components/foot'

export default {
  components: { CodeInput, Banner, Foot },
  data: function () {
    return {
      sampleCode: ``
    }
  },
  methods: {
    updateUserInput: function(userInput) {
      this.sampleCode = userInput
    }
  }
}
</script>
