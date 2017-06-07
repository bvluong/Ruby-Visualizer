<template lang="html">

  <div class='body-section'>
    <div class='code-input'>
        <Editor  id='editor' v-model="userInput"
        lang="ruby" theme="github"  height="400" width="100%"></Editor>

      <section class="input-buttons">
        <button type="button" name="button"
        @click="moveBackward">Backward
        </button>
        <div class="frame-count">
          Step {{stackFrame}} of {{ codeLength }}
        </div>
        <button type="button" name="button"
        @click="moveForward">Forward
        </button>
      </section>

      <button type="button" name="button"
      @click="runCode(userInput)">Run Code
      </button>

    </div>
    <div id='display-code'>
      <DisplayCode :frame="currentFrame"></DisplayCode>
    </div>
  </div>
</template>

<script>
import Editor from 'vue2-ace-editor';
import 'brace/mode/ruby';
import 'brace/mode/less';
import 'brace/theme/github';
import { mapActions } from 'vuex';
import DisplayCode from './display_code';
export default {
  computed: {
    forwardStack () {
     return this.$store.state.code
   },
    currentFrame () {
      return this.forwardStack[0] ? this.forwardStack[0] : false
    },
    codeLength () {
      if (this.forwardStack[0]) {
        return (this.forwardStack.length + this.backwardStack.length);
      } else {
        return 0;
      }
    }
  },
  data: function () {
    return {
      userInput:
      `def test(arr)
                h = {two: 2}
                x = 'test'
                y = 1.3
                (0..5).step do |idx|
                  y += idx
                end
                z = 2
                return x+y
              end
              test([1,1,3,4])`,
      backwardStack: [],
      previousLine: false,
      stackFrame: 0,
      buttonUpdate: true
    }
  },
  components: { Editor, DisplayCode },
  updated: function () {
    if (this.buttonUpdate) {
      this.selectLine()
    }
  },
  methods: {
    moveForward: function () {
      if (this.forwardStack.length > 1) {
        this.backwardStack.push(this.forwardStack.shift())
        this.stackFrame +=1
        this.buttonUpdate = true
      }
    },
    moveBackward: function () {
      if (this.backwardStack.length > 0) {
        this.forwardStack.unshift(this.backwardStack.pop())
        this.stackFrame -= 1
        this.buttonUpdate = true
      }
    },
    runCode: function(userInput) {
      this.stackFrame = 1
      this.forwardStack = []
      this.backwardStack = []
      this.submitCode(userInput)
      this.buttonUpdate = true
    },
    selectLine() {
      var editor = ace.edit('editor')
      if (this.currentFrame) {
        const lineno = parseInt(Object.keys(this.currentFrame)[0].slice(6))
        editor.selection.clearSelection();
        editor.selection.moveCursorToPosition({row: lineno-1, column: 0})
        if (this.stackFrame != 1) {
          this.buttonUpdate = false
        }
      }
    },
    ...mapActions(['submitCode'])
  }
}
</script>
