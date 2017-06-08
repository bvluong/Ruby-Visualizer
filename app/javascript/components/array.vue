<template>
  <div class='variable'>
    <h3>{{arrName}}</h3>
    <h4>{{arrVal}}</h4>
    <h4>Array</h4>
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
