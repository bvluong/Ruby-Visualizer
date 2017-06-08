<template>
  <div id='display'>
    <h2>{{errors}}</h2>
    <h2>{{returnValue}}</h2>
    <ul class='function-list' v-for="(stack, idx) in stackFrame">
        <Frame :stacks='stack' :numWidth= 'idx' :stackNum='stackFrame.length - idx' :isCurrentFrame='idx === 0'></Frame>
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
        return this.lineNo ? this.frame[this.lineNo] : []
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
