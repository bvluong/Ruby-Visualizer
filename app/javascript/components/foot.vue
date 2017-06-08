<template>
  <nav class='footer'>
    <ul class="examples">
      More detailed information about what to do, restrictions on input, etc., can go here.
      {{userInput}}
    </ul>
    <button type="button" name="button"   v-on:click="updateCode(food)"></button>
  </nav>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  computed: {

  },
  data: function () {
    return {
      userInput: this.$store.state.inputCode,
      food: `def food(e)
    e += 1
    return e
end
food(1)`
    }
  },
  methods: {
    updateCode: function(userInput) {
      this.$emit('updateCode', userInput)
    }
  }
}
</script>
