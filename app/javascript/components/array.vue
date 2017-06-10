<template>
  <div class='variable'>
    <li class='variable-type'>{{type}}</li>
    <li class='variable-name'>{{arrName}}</li>
    <li class='variable-arrow'><img class="arrow" src="http://res.cloudinary.com/djrgebhxz/image/upload/v1497033999/img-thing_aedlsa.jpg"/></li>
    <li class='variable-val blue'>{{arrVal}}</li>
  </div>
</template>

<script>
export default {
  props: ['array', 'type'],
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
