<template>
  <div id='display'>
    <!-- <h2>Current Frame: {{stackFrame}}</h2> -->
    <ul class='function-list'>
      <li v-for="stack in stackFrame">
        <h2>Method: {{frameName(stack)}}</h2>
        <h3>Variables:</h3>
        <ul class='var-list'>
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
        vars.forEach((v) => {
          if (stack[v] instanceof Array ) {
            vals.push(`${v}: [${stack[v]}]`)
          } else if (stack[v] instanceof Object) {
            vals.push(`${v}: ${JSON.stringify(stack[v])}`)
          } else if (stack[v] === null){
            null
          } else {
            vals.push(`${v}: ${stack[v]}`)
          }



        })
        return vals
      },
    },
    props: ['frame']
  }
</script>

<style module>
  .red{
    color: red;
  }
</style>
