<template>
  <div id='display'>
    <h1>Current Frame: {{frame}}</h1>
    <ul>
      <li v-for="stack in stackFrame">
        <h2>Method: {{frameName(stack)}}</h2>
        <h3>Variables:</h3>
        <ul>
          <li v-for='varPair in getVariables(stack)'>
            {{varPair}}
          </li>
        </ul>
      </li>
    </ul>
  </div>
</template>

<script>
  export default {
    computed: {
      lineNo: function () {
        return Object.keys(this.frame)[0]
      },
      stackFrame () {
        return this.frame[this.lineNo]
      },
    },
    methods: {
      frameName: function (stack) {
        return stack['method_name']
      },
      getVariables: function (stack) {
        let vars = Object.keys(stack)
        vars.shift()
        let vals = []
        vars.forEach((v) => vals.push(`${v}: ${stack[v]}`))
        return vals
      },
    },
    props: ['frame']
  }
</script>
