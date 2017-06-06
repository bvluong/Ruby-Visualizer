<template>
  <div id='display'>
    <p>
      {{stack}}
    </p>

    <h1>Current Frame</h1>
    <h2>Method: {{frameName}}</h2>
    <h3>Variables:</h3>
    <ul>
      {{variables}}
    </ul>
    <!-- <svg width="500" height="500">
    <g><text x='0' y='20'>Frame information</text></g>
      <circle cx="50" cy="50" r="5" stroke="green" stroke-width="4" fill="yellow" />
      <canvas></canvas>
    <g><text x='250' y='20'>Detail</text></text></g>
    </svg> -->
  </div>
</template>

<script>
  export default {
    computed: {
      code () {
        return this.$store.state.code
      },
      stack () {
        return this.code[0]
      },
      stackFrame () {
        if (this.code.length > 0) {
          return this.stack['lineno2'][0]
        }
      },
      frameName () {
        if (this.code.length > 0) {
          return this.stackFrame['method_name']
        }
      },
      variables () {
        if (this.code.length > 0) {
          let vars = Object.keys(this.stackFrame)
          vars.shift()
          let vals = []
          vars.forEach((v) => vals.push(this.stackFrame[v]))
          return vals
        }
      }

    },
  }
</script>


<style scoped>
  #display{
    background-color: pink;
  }
</style>
