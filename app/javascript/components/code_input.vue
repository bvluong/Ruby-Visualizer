<template lang="html">
  <div class='code-input'>
    <div ref="editor">
      <Editor v-model="userInput" id='editor'
      lang="ruby" theme="github"  height="400" width="45%"></Editor>
    </div>
    <section class="input-buttons">
      <button type="button" name="button"
        @click="moveBackward">Backward
      </button>
      <button type="button" name="button"
        @click="runCode(userInput)">Run Code
      </button>
      <button type="button" name="button"
        @click="moveForward">Forward
      </button>
    </section>
    <DisplayCode :frame="currentFrame"></DisplayCode>
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
      return this.forwardStack[0] ? this.forwardStack[0] : {}
    }
  },
  data: function () {
    return {
      userInput: `def calc(x,y)
          x += 1
          y += 1
          return x+y
      end
      calc(1,1)`,
      backwardStack: [],
      previousLine: false
    }
  },
  components: { Editor, DisplayCode },
  updated: function () {
    this.handleHighlight()
  },
  methods: {
    moveForward: function () {
      if (this.forwardStack.length > 1) {
        this.backwardStack.push(this.forwardStack.shift())
      }
    },
    moveBackward: function () {
      if (this.backwardStack.length > 0) {
        this.forwardStack.unshift(this.backwardStack.pop())
      }
    },
    runCode: function(userInput) {
      this.submitCode(userInput)
    },
    handleHighlight() {
      var editor = ace.edit('editor')
      var Range = ace.acequire('ace/range').Range
      const lineno = parseInt(Object.keys(this.currentFrame)[0].slice(6))
      if (this.previousLine) {
        this.unhighlightLine(editor)
      }
      editor.session.removeMarker(1, "ace_active-line", "fullLine");
      this.highlightLine(editor, Range, lineno)
    },
    unhighlightLine: function (editor) {
      editor.session.removeMarker(this.previousLine, "ace_active-line", "fullLine");
    },
    highlightLine: function (editor, Range, lineno) {
      this.previousLine = editor.session.addMarker( new Range(lineno-1, 0, lineno-1, 1), "ace_active-line", "fullLine");
    },
    ...mapActions(['submitCode'])
  }
}
</script>
