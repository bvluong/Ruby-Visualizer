<template lang="html">
  <div id='editor'>
    <editor v-model="userInput" @init="editorInit();" lang="ruby" theme="chrome" width="500" height="100"></editor>
    <button type="button" class="run" name="button"
      @click="submitCode(userInput)">
    </button>
    <span>{{code}}</span>
  </div>
</template>

<script>
import Editor from 'vue2-ace-editor';
import { mapActions } from 'vuex';
console.log(mapActions);
export default {
  computed: {
    code () {
     return this.$store.state.code
   }
  },
  data: function () {
    return {
      userInput: "sadas"
    }
  },
  components: { Editor },
  methods: {
    editorInit: function () {
        require('brace/mode/ruby');
        require('brace/mode/less');
        require('brace/theme/chrome');
    },
    ...mapActions(['submitCode'])
  }
}
</script>

<style lang="css">
p {
  font-size: 2em;
  text-align: center;
}
</style>
