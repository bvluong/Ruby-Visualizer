<template>
  <div class='variable'>
    <li class='variable-type'>[hash]</li>
    <li>{{hashName}}</li>
    <li>----></li>
    <li>{{hashVal}}</li>
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
