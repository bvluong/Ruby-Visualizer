<template>
    <ul class='frame-box' v-bind:style="{ width: boxWidth + '%', border: '2px solid ' + borderColor}">
      {{getVariables}}
      <ul>
        <h2>{{name}}</h2>
        <h4>{{'stack no.: ' + stackNum}}</h4>
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
      otherTypes: [],
      name: '',
      boxWidth: 60,
      borderColor: '#d8d8d8'
    }
  },
  created: function () {
    this.getWidth
    this.changeBorder
  },
  props: ['stacks', 'stackNum', 'isCurrentFrame', 'numWidth'],
  computed: {
    getVariables: function () {
      let vars = Object.keys(this.stacks)
      let localArrays = []
      let localHashes = []
      let localOtherTypes = []
      let nullVals = []
      vars.forEach((v) => {
        switch (true){
          case v === 'method_name':
            this.name = this.stacks[v]
            break;
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
    },
    getWidth: function () {
      this.boxWidth += (this.numWidth+1)*2
    },
    changeBorder: function  () {
      this.borderColor = this.isCurrentFrame ? '#34dc00' : '#d8d8d8'
    }
  }
}
</script>
