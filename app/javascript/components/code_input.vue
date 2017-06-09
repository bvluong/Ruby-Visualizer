<template lang="html">

  <div class='body-section'>
    <div class='code-input'>
      {{updateInputCode}}
        <Editor  id='editor' v-model="userInput"
        lang="ruby" theme="xcode"  height="400" width="100%"></Editor>

      <section class="input-buttons">

        <i class="fa fa-fast-backward" aria-hidden="true" id='fa-controls' @click="moveFirst"></i>
        <i class="fa fa-step-backward" aria-hidden="true" id='fa-controls' @click="moveBackward"></i>
        <div class="frame-count">
          Step {{stackFrame}} of {{ codeLength }}
        </div>
        <i class="fa fa-step-forward" aria-hidden="true" id='fa-controls' @click="moveForward"></i>
        <i class="fa fa-fast-forward" aria-hidden="true" id='fa-controls' @click="moveLast"></i>

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
import 'brace/theme/xcode';
import { mapActions } from 'vuex';
import DisplayCode from './display_code';
export default {
  watch: {
    userInput: function() {
      this.$emit("updateCode", this.userInput)
    }
  },
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
    },
    updateInputCode() {
      this.userInput = this.sampleCode
    }
  },
  data: function () {
    return {
      userInput: this.sampleCode,
      backwardStack: [],
      previousLine: false,
      stackFrame: 0,
      buttonUpdate: true,
      firstRun: false
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
      this.firstRun = true
    },
    selectLine() {
      var editor = ace.edit('editor')
      if (this.currentFrame) {
        const lineno = parseInt(Object.keys(this.currentFrame)[0].slice(6))
        editor.selection.clearSelection();
        editor.selection.moveCursorToPosition({row: lineno-1, column: 0})
        if (this.stackFrame != 0) {
          if (this.firstRun) {
          this.buttonUpdate = false
          }
        }
      }
    },
    ...mapActions(['submitCode'])
  },
  props: ['sampleCode']
}
</script>
