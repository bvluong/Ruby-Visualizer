<template>
  <div>
    <ul class='frame-box' v-bind:style="{ width: boxWidth + '%'}">
      <ul class='box-header' v-bind:style="{background: borderColor}">
        <h3>{{name}}</h3>
        <h4>[{{'stack no: ' + stackNum}}]</h4>
      </ul>
      {{getVariables}}
      <ul class='variable-cols'>
        <li class='variable-type not-bold'>Type</li>
        <li class='variable-name not-bold'>Variable</li>
        <li class='variable-arrow'></li>
        <li class='variable-val'>Value</li>
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
  </div>
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
      boxWidth: 90,
      borderColor: '#393e46'
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
      this.borderColor = this.isCurrentFrame ? '#838890' : '#393e46'
    }
  }
}
</script>
