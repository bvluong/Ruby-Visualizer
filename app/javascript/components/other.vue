<template>
  <div class='variable'>
    <li>{{otherName}}</li>
    <li>{{getType === 'symbol' ? otherVal.slice(0, this.otherVal.length-3) : otherVal}}</li>
    <li>{{getType}}</li>
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
        case typeof this.otherVal === 'string':
          if (this.otherVal.slice(this.otherVal.length-3) === 'SYM') {
            return 'symbol'
          } else {
            return 'string'
          }
          break;
        case typeof this.otherVal === 'number':
          if (this.otherVal % 1 === 0) {
            return 'integer'
          } else {
            return 'float'
          }
          break;
        case typeof this.otherVal === 'boolean':
          return 'boolean'
        default:
          return null
      }

    }
  }
}
</script>
