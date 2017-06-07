<template lang="html">
  <div id='body-section'>
    <div id='editor' class='code-input'>
      <editor class="editor" v-model="userInput" @init="editorInit();"
      lang="ruby" theme="github"  height="400" width="100%"></editor>

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

      <!-- <ul>
      <li v-for="stack in forwardStack">
      {{ stack }}
      </li>
      </ul>
      <ul>
      <li v-for="bstack in backwardStack">
      {{ bstack }}
      </li>
      </ul>
      <span>{{forwardStack}}</span> -->

    </div>
    <div id='display-code'>
      <DisplayCode :frame="currentFrame"></DisplayCode>
    </div>
  </div>

</template>

<script>
import Editor from 'vue2-ace-editor';
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
      userInput:
      `def test(arr)
                h = {two: 2}
                x = 'test'
                y = 1.3
                arr.map {|x| x*2}
                z = 2
                return x+y
              end
              test([1,1,3,4])`,
      backwardStack: []
    }
  },
  components: { Editor, DisplayCode },
  methods: {
    moveForward: function () {
      this.backwardStack.push(this.forwardStack.shift())
    },
    moveBackward: function () {
      this.forwardStack.unshift(this.backwardStack.pop())
    },
    editorInit: function () {
        require('brace/mode/ruby');
        require('brace/mode/less');
        require('brace/theme/github');
    },
    ...mapActions(['submitCode'])
  }
}
</script>
