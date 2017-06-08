<template>
  <div class='variable'>
    <h3>{{hashName}}</h3>
    <h4>{{hashVal}}</h4>
    <h4>hash</h4>
  </div>
</template>

<script>
export default {
  props: ['hash'],
  computed: {
    hashName: function () {
      return Object.keys(this.hash)[0]
    },
    hashVal: function () {
      return this.hash[this.hashName]
    }
  }
}
</script>
