<template>
  <div id='display'>
    <h2>{{errors}}</h2>
    <h2>{{returnValue}}</h2>
    <ul class='function-list'  >
      <li v-for="stack in stackFrame">
        <Frame :stacks='stack' ></Frame>
      </li>
    </ul>
  </div>
</template>

<script>
import Frame from './frame'
  export default {
    components: { Frame },
    computed: {
      errors: function () {
        if (Object.keys(this.frame).includes('errors')) {
          return this.frame['errors']
        }
      },
      returnValue: function () {
        if (Object.keys(this.frame).includes('return_value')){
          return this.frame['return_value']
        }
      },
      lineNo: function () {
        if (Object.keys(this.frame)[0] === 'errors') {
          return null
        } else {
          return Object.keys(this.frame)[0]
        }
      },
      stackFrame () {
        if (this.lineNo){
          return this.frame[this.lineNo]
        } else {
          return []
        }

      },
    },
    methods: {
      frameName: function (stack) {
        // return stack['method_name']
      },
      // getVariables: function (stack) {
      //   let vars = Object.keys(stack)
      //   vars.shift()
      //   // let cols = []
      //   let vals = ['VALUE']
      //   let types = ['TYPE']
      //   let currVars = ['NAME']
      //   vars.forEach((v) => {
      //     switch (true){
      //       case stack[v] instanceof Array:
      //         vals.push(`[${stack[v]}]`)
      //         types.push('array')
      //         currVars.push(v)
      //         // cols.push(`[${v}], [${stack[v]}], ['ARRAY']`)
      //         break;
      //       case stack[v] instanceof Object:
      //         let hashDisplay = this.getHashValues(stack[v])
      //         vals.push(`${hashDisplay}`)
      //         types.push('hash')
      //         currVars.push(v)
      //         // cols.push(`[${v}], [${stack[v]}], ['HASH']`)
      //         break;
      //       case typeof stack[v] === 'string':
      //         if (stack[v].slice(stack[v].length-3) === 'SYM') {
      //           vals.push(`:${stack[v].slice(0, stack[v].length-3)}`)
      //           types.push('symbol')
      //           currVars.push(v)
      //           // cols.push(`[${v}], [${stack[v]}], ['SYMBOL']`)
      //         } else {
      //           vals.push(`${stack[v]}`)
      //           types.push('string')
      //           currVars.push(v)
      //           // cols.push(`[${v}], [${stack[v]}], ['STRING']`)
      //         }
      //         break;
      //       case typeof stack[v] === 'number':
      //         if (stack[v] % 1 === 0) {
      //           vals.push(`${stack[v]}`)
      //           types.push('integer')
      //           currVars.push(v)
      //           // cols.push(`[${v}], [${stack[v]}], ['INTEGER']`)
      //         } else {
      //           vals.push(`${stack[v]}`)
      //           types.push('float')
      //           currVars.push(v)
      //           // cols.push(`[${v}], [${stack[v]}], ['FLOAT']`)
      //         }
      //         break;
      //       case typeof stack[v] === 'boolean':
      //         vals.push(`${stack[v]}`)
      //         types.push('boolean')
      //         currVars.push(v)
      //         // cols.push(`[${v}], [${stack[v]}], ['BOOLEAN']`)
      //       default:
      //         null
      //       }
      //     })
      //
      //   return [currVars, vals, types]
      // },
      getHashValues: function (hash) {
        let keys = Object.keys(hash)
        let hashVals = []
        keys.forEach(key => hashVals.push(` ${key}: ${hash[key]}`))
        return `{${hashVals}}`
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
