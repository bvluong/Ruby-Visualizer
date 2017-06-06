<template>
  <div id='display'>
    <h1>Current Frame: {{frame}}</h1>
    <ul>
      {{stackFrame}}
      <li v-for="stack in stackFrame">
        <h2>Method: {{frameName(stack)}}</h2>
        <h3>Variables:</h3>
        <ul>
          <li v-for='varPair in variables'>
            {{varPair}}
          </li>
        </ul>
      </li>

    </ul>
  </div>
</template>

<script>
  export default {
    data: function () {
      return {
        variables: [],
      }
    },
    computed: {
      lineNo: function () {
        if (this.frame) {
          return Object.keys(this.frame)[0]
        }
      },
      stackFrame () {
        if (this.frame) {
          return this.frame[this.lineNo]
        }
      },
    },

    methods: {
      frameName: function (stack) {
        if (this.stackFrame) {
          this.getVariables(stack)
          return stack['method_name']
        }
      },
      getVariables: function (stack) {
        if (this.frame) {
          let vars = Object.keys(stack)
          vars.shift()
          let vals = []
          vars.forEach((v) => vals.push(`${v}: ${stack[v]}`))
          this.variables = vals
        }
      },
    },
    props: ['frame']
  }
</script>


<style scoped>
  #display{
    background-color: pink;
  }
</style>
