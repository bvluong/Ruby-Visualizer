<template lang="html">

  <div class="main-body">
    <div class='body-section'>
      <div class='code-input'>
        {{updateInputCode}}
          <Editor  id='editor' v-model="userInput"
          lang="ruby" theme="sqlserver"  height="420" width="100%"></Editor>
        <section class="input-buttons">
          <button type="button" name="button" :disabled="isDisabled" @click="moveFirst"
          :style=" isDisabled ? {color: color, background: background} : null">
            <i class="fa fa-chevron-left" aria-hidden="true"></i>
            <i class="fa fa-chevron-left" aria-hidden="true"></i> First
          </button>
          <button type="button" name="button" :disabled="isDisabled" @click="moveBackward"
          :style=" isDisabled ? {color: color, background: background} : null">
            <i class="fa fa-chevron-left" aria-hidden="true"></i> Back
          </button>
          <div class="frame-count">
            Step {{stackFrame}} of {{ codeLength }}
          </div>
          <button type="button" name="button" :disabled="isDisabled" @click="moveForward"
          :style=" isDisabled ? {color: color, background: background} : null">Next
            <i class="fa fa-chevron-right" aria-hidden="true"></i>
          </button>
          <button type="button" name="button" :disabled="isDisabled" @click="moveLast"
          :style=" isDisabled ? {color: color, background: background} : null">Last
            <i class="fa fa-chevron-right" aria-hidden="true"></i>
            <i class="fa fa-chevron-right" aria-hidden="true"></i>
          </button>
        </section>
        <button type="button" name="button" class='run'
          :disabled="isDisabled" :style=" isDisabled ? {color: color, background: background} : null"
        @click="runCode(userInput)">Compile
        </button>

      </div>
      <div id='display-code'>
        <DisplayCode :frame="currentFrame"></DisplayCode>
      </div>
    </div>
  </div>
</template>

<script>
import Editor from 'vue2-ace-editor';
import 'brace/mode/ruby';
import 'brace/mode/less';
import 'brace/theme/sqlserver';
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
      firstRun: false,
      isDisabled: false,
      color: "#545454",
      background: "#dbd9d9"
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
      this.isDisabled = true
      this.submitCode(userInput).then(() => this.isDisabled=false,
      err => this.isDisabled=false)
      this.buttonUpdate = true
      this.firstRun = true
    },
    selectLine() {
      var editor = ace.edit('editor')
      if (this.currentFrame) {
        let lineno = parseInt(Object.keys(this.currentFrame)[0].slice(6))
        editor.selection.clearSelection();
        if (Object.keys(this.currentFrame)[0] == "errors" && this.backwardStack.length > 0) {
          lineno = parseInt(Object.keys(this.backwardStack[this.backwardStack.length-1])[0].slice(6))
        }
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
