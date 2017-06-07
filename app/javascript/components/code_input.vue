<template lang="html">

  <div class='body-section'>
    <div class='code-input'>
        <Editor  id='editor' v-model="userInput"
        lang="ruby" theme="solarized_light"  height="400" width="100%"></Editor>

      <section class="input-buttons">
        <button type="button" name="button"
        @click="moveFirst"><< First
        </button>
        <button type="button" name="button"
        @click="moveBackward">< Back
        </button>
        <div class="frame-count">
          Step {{stackFrame}} of {{ codeLength }}
        </div>
        <button type="button" name="button"
        @click="moveForward">Forward >
        </button>
        <button type="button" name="button"
        @click="moveLast">Last >>
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
import 'brace/theme/solarized_light';
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
      `def sum_arr(arr)
    if  arr.length < 1
        return 0
    else
        return arr[-1] + sum_arr(arr[0..-2])
    end
end

sum_arr([1,2,3,4])`,
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
    moveFirst: function () {
      while (this.backwardStack.length >= 1) {
        this.moveBackward()
      }
    },
    moveLast: function () {
      while (this.forwardStack.length > 1) {
        this.moveForward()
      }
    },
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
        if (this.stackFrame != 0) {
          this.buttonUpdate = false
        }
      }
    },
    ...mapActions(['submitCode'])
  }
}
</script>
