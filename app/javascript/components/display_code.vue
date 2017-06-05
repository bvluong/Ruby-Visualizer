<template>
  <div id='display'>
    <p>
      {{stack}}
    </p>
    <svg width="500" height="500">
    <g><text x='0' y='20'>Frame information</text></g>
      <circle cx="50" cy="50" r="5" stroke="green" stroke-width="4" fill="yellow" />
      <canvas></canvas>
    <g><text x='250' y='20'>Detail</text></text></g>
    </svg>
  </div>
</template>

<script>
  export default {
    computed: {
      stack () {
        return this.$store.state.code[]
      }
    },
  }
</script>


<style scoped>
  #display{
    background-color: pink;
  }
</style>
