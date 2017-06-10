<template>
  <div class='variable'>
    <li class='variable-type'>{{type}}</li>
      <li class='variable-name'>{{otherName}}</li>
      <li class='variable-arrow green'><img class="arrow" src="http://res.cloudinary.com/djrgebhxz/image/upload/v1497033999/img-thing_aedlsa.jpg"/></li>
      <li class='variable-val blue'>{{otherVal}}</li>
  </div>
</template>

<script>
export default {
  props: ['other', 'type'],
  computed: {
    otherName: function () {
      return Object.keys(this.other)[0]
    },
    otherVal: function () {
      switch (true) {
        case this.type === 'string':
          return `'${this.other[this.otherName]}'`
          break
        case this.type === 'symbol':
          return `:${this.other[this.otherName].slice(0, this.other[this.otherName].length-3)}`
          break
        default:
          return this.other[this.otherName]
      }
      return this.other[this.otherName]
    }
  }
}
</script>
