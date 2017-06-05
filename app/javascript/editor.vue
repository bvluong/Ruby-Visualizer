<template>
  <div id='editor'>
    <editor v-model="code" @init="editorInit();" lang="ruby" theme="chrome" width="500" height="100"></editor>
  </div>
</template>



<script>

import Editor from 'vue2-ace-editor';

export default {
  data: function () {
    return {
      code: ""
    }
  },
  components: { Editor },
  methods:{
    editorInit:function () {
        require('brace/mode/ruby');
        require('brace/mode/less');
        require('brace/theme/chrome');
    }
},
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
