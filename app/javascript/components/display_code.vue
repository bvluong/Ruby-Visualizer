<template>
  <div id='display'>
    <h2>Current Frame: {{frame}}</h2>
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
        if (this.frame[this.lineNo]) {
          return this.frame[this.lineNo]
        } else {
          return []
        }

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
          switch (true){
            case stack[v] instanceof Array:
              vals.push(`(ARRAY) ${v}: [${stack[v]}]`)
              break;
            case stack[v] instanceof Object:
              let hashDisplay = this.getHashValues(stack[v])
              vals.push(`(HASH) ${v}: ${hashDisplay}`)
              break;
            case typeof stack[v] === 'string':
              vals.push(`(STRING) ${v}: ${stack[v]}`)
              break;
            case typeof stack[v] === 'number':
              vals.push(`(NUMBER)  ${v}: ${stack[v]}`)
              break;
            default:
              null
            }
          })

        return vals
      },
      getHashValues: function (hash) {
        let keys = Object.keys(hash)
        let hashVals = []
        keys.forEach(key => hashVals.push(`${key}: ${hash[key]}`))
        return hashVals
      }
    },
    props: ['frame']
  }
</script>

<style module>
  .red{
    color: red;
  }
</style>
