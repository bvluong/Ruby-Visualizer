<template>
  <div class='variable'>
    <li class='variable-type'>array</li>
    <li>{{arrName}}</li>
    <li>----></li>
    <li>{{arrVal}}</li>
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
