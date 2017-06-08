<template>
  <ul>
    {{getVariables}}
    <ul class='variable'>
      <h3>Name</h3>
      <h3>Value</h3>
      <h3>Type</h3>
    </ul>
    <li v-for='arr in arrays'>
      <ArrayType :array='arr'></ArrayType>
    </li>
    <li v-for='hash in hashes'>
      <HashType :hash='hash'></HashType>
    </li>
    <li v-for='other in otherTypes'>
      <OtherType :other='other'></OtherType>
    </li>
  </ul>
</template>

<script>
import OtherType from './other'
import ArrayType from './array'
import HashType from './hash'
export default {
  components: { OtherType, ArrayType, HashType },
  data: function () {
    return {
      arrays: [],
      hashes: [],
      otherTypes: []
    }
  },
  props: ['stacks'],
  computed: {
    getVariables: function () {
      let vars = Object.keys(this.stacks)
      let localArrays = []
      let localHashes = []
      let localOtherTypes = []
      let nullVals = []
      vars.forEach((v) => {
        switch (true){
          case this.stacks[v] instanceof Array:
            localArrays.push({[v]: this.stacks[v]})
            break;
          case this.stacks[v] instanceof Object:
            localHashes.push({[v]: this.stacks[v]})
            break;
          case this.stacks[v] === null:
            nullVals.push({[v]: this.stacks[v]})
            break;
          default:
            localOtherTypes.push({[v]: this.stacks[v]})
          }
      })
      this.arrays = localArrays
      this.hashes = localHashes
      this.otherTypes = localOtherTypes
    }
  }
}
</script>
