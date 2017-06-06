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
        @click="submitCode(userInput)">Run Code
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
      lastline: false
    }
  },
  components: { Editor, DisplayCode },
  methods: {
    moveForward: function () {
      this.backwardStack.push(this.forwardStack.shift())
      this.highlightLine()
    },
    moveBackward: function () {
      this.forwardStack.unshift(this.backwardStack.pop())
      this.highlightLine()
    },
    highlightLine: function () {
      var editor = ace.edit('editor')
      var Range = ace.acequire('ace/range').Range
      const lineno = parseInt(Object.keys(this.currentFrame)[0].slice(6))
      if (this.lastline) {
        editor.session.removeMarker(this.lastline, "ace_active-line", "fullLine");
      }
      this.lastline = editor.session.addMarker( new Range(lineno, 0, lineno, 1), "ace_active-line", "fullLine");
    },
    ...mapActions(['submitCode'])
  }
}
</script>
