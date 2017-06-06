<template>
  <div id='display'>
    <p>
      {{code}}
    </p>

    <h1>Current Frame</h1>
    <h2>Method: {{frameName}}</h2>
    <h3>Variables:</h3>
    <ul>
      {{stackFrame}}
    </ul>
  </div>
</template>

<script>
  export default {
    computed: {
      code () {
        if (this.frame) {
          return this.frame
        } else {
          return {}
        }
      },
      lineNo () {
        return Object.keys(this.code)[0]
      },
      stackFrame () {
        if (this.frame) {
          return this.code[this.lineNo][0]
        }
      },
      frameName () {
        if (this.stackFrame) {
          return this.stackFrame['method_name']
        }
      },
      // variables () {
      //   if (this.code.length > 0) {
      //     let vars = Object.keys(this.stackFrame)
      //     vars.shift()
      //     let vals = []
      //     vars.forEach((v) => vals.push(this.stackFrame[v]))
      //     return vals
      //   }
      // },
      // varItems () {
      //   if (this.code.length > 0) {
      //
      //   }
      // }
    },
    props: ['frame']
  }
</script>


<style scoped>
  #display{
    background-color: pink;
  }
</style>
