<template>
  <div class='variable'>
    <li>{{arrName}}</li>
    <li>{{arrVal}}</li>
    <li>array</li>
  </div>
</template>

<script>
export default {
  props: ['array'],
  computed: {
    arrName: function () {
      return Object.keys(this.array)[0]
    },
    arrVal: function () {
      return this.array[this.arrName]
    }
  }
}
</script>
