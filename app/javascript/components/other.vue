<template>
  <div class='variable'>
    <li class='variable-type'>{{getType}}</li>
      <li class='variable-name'>{{otherName}}</li>
      <li class='variable-arrow green'><i class="fa fa-long-arrow-right" aria-hidden="true"></i></li>
      <li class='variable-val blue'>{{otherVal}}</li>
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
      switch (true) {
        case this.getType === 'string':
          return `'${this.other[this.otherName]}'`
          break
        case this.getType === 'symbol':
          return `:${this.other[this.otherName].slice(0, this.other[this.otherName].length-3)}`
          break
        default:
          return this.other[this.otherName]
      }
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
