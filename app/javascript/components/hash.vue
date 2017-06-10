<template>
  <div class='variable'>
    <!-- {{hash}} -->
    <li class='variable-type'>{{type}}</li>
    <li class='variable-name'>{{hashName}}</li>
    <li class='variable-arrow green'><img class="arrow" src="http://res.cloudinary.com/djrgebhxz/image/upload/v1497033999/img-thing_aedlsa.jpg"/></li>
    <li class='variable-val blue'>{{hashVal}}</li>
</div>
</template>

<script>
export default {
  props: ['hash', 'type'],
  computed: {
    hashName: function () {
      return Object.keys(this.hash)[0]
    },
    hashVal: function () {
      let plainObj = (this.hash[this.hashName])
      let newStrings = []
      Object.keys(plainObj).forEach(key => {
        newStrings.push(`${key} => ${plainObj[key]}`)
      })
      return `{${newStrings.join(',')}}`
    }
  }
}
</script>
