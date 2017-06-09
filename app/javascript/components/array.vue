<template>
  <div class='variable'>
    <li class='variable-type'>array</li>
    <li class='variable-name'>{{arrName}}</li>
    <li class='variable-arrow pink'><i class="fa fa-long-arrow-right" aria-hidden="true"></i></li>
    <li class='variable-val blue'>{{arrVal}}</li>
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
