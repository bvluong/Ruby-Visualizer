<template>
  <div class='variable'>
    <li>{{hashName}}</li>
    <li>{{hashVal}}</li>
    <li>hash</li>
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
