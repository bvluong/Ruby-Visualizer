<template>
  <div class='variable'>
    <li class='variable-type'>{{getType}}</li>
    <li>{{otherName}}</li>
    <li>----></li>
    <li>{{getType === 'symbol' ? `:${otherVal.slice(0, this.otherVal.length-3)}` : `${otherVal}`}}</li>
  </div>
</template>

<script>
export default {
  props: ['other'],
  computed: {
    otherName: function () {
      return Object.keys(this.other)[0]
    },
    otherVal: function () {
      return this.other[this.otherName]
    },
    getType: function () {
      switch (true) {
        case typeof this.other[this.otherName] === 'string':
          if (this.other[this.otherName].slice(this.other[this.otherName].length-3) === 'SYM') {
            return 'symbol'
          } else {
            return 'string'
          }
          break;
        case typeof this.other[this.otherName] === 'number':
          if (this.other[this.otherName] % 1 === 0) {
            return 'integer'
          } else {
            return 'float'
          }
          break;
        case typeof this.other[this.otherName] === 'boolean':
          return 'boolean'
        default:
          return null
      }

    }
  }
}
</script>
