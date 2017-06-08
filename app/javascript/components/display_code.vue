<template>
  <div id='display'>
    <h2>{{errors}}</h2>
    <h2>{{returnValue}}</h2>
    <ul class='function-list'>
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
        if (Object.keys(this.frame)[0] === 'errors' || Object.keys(this.frame)[0] === 'return_value') {
          return null
        } else {
          return Object.keys(this.frame)[0]
        }
      },
      stackFrame () {
        if (this.lineNo){
          let withoutExtras = this.frame[this.lineNo].slice()
          // withoutExtras.forEach(stackObj => {
          //   delete stackObj['method_name']
          // })
          return withoutExtras

        } else {
          return []
        }

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
