<template>
  <div class='variable'>
    <li class='variable-type'>hash</li>
      <li class='variable-name'>{{hashName}}</li>
      <li class='variable-arrow pink'>----></li>
      <li class='variable-val blue'>{{hashVal}}</li>
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
