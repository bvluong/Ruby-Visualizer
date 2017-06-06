<template lang="html">
  <div id='editor' class='test'>
    <editor v-model="userInput" @init="editorInit();" lang="ruby" theme="chrome" width="500" height="100"></editor>
    <button type="button" name="button"
      @click="moveBackward">Backward
    </button>
    <button type="button" name="button"
      @click="submitCode(userInput)">Run Code
    </button>
    <button type="button" name="button"
      @click="moveForward">Forward
    </button>
    <ul>
      <li v-for="stack in forwardStack">
        {{ stack }}
      </li>
    </ul>
    <ul>
      <li v-for="bstack in backwardStack">
          {{ bstack }}
      </li>
    </ul>
    <span>{{forwardStack}}</span>
  </div>
</template>

<script>
import Editor from 'vue2-ace-editor';
import { mapActions } from 'vuex';
export default {
  computed: {
    forwardStack () {
     return this.$store.state.code
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
      backwardStack: []
    }
  },
  components: { Editor },
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
        require('brace/theme/chrome');
    },
    ...mapActions(['submitCode'])
  }
}
</script>
