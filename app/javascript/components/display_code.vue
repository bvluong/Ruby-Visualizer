<template>
  <div id='display'>
    <h2 class='green'>{{errors}}</h2>
    <h2 class='green'>{{returnValue}}</h2>
    <div class='instructions' v-if='!frame'>
      <h3>Welcome to Ruby Visualizer.</h3>

      <h4>This site is for coders learning the Ruby programming language.</h4>

      Instructions:
      <ul>
        <li>
          Input your code in the text editor to the left (or click on one of our example algorithms on the top right of this page).
        </li>
        <li>
          Once your code is ready to run, click the 'Compile' button.
        </li>
        <li>
          You will start to see information about your code being displayed on the right side of the page. Use the arrow buttons to navigate through each line of your code and see how your variables change.
        </li>
      </ul>


    </div>
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
