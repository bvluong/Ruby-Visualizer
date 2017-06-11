<template>
  <div>
    <ul class='frame-box' :style="{ width: boxWidth + '%'}">
      <ul class='box-header' :style="{background: borderColor}">
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
      <li v-for='(arr, idx) in arrays'>
        <ArrayType :array='arr' :type='idx === 0 ? a : null'></ArrayType>
      </li>
      <li v-for='(hash, idx) in hashes'>
        <HashType :hash='hash' :type='idx === 0 ? h : null'></HashType>
      </li>
      <li v-for='(string, idx) in strings'>
        <OtherType :other='string' :type='idx === 0 ? s : null'></OtherType>
      </li>
      <li v-for='(symbol, idx) in symbols'>
        <OtherType :other='symbol' :type='idx === 0 ? sy : null'></OtherType>
      </li>
      <li v-for='(integer, idx) in integers'>
        <OtherType :other='integer' :type='idx === 0 ? i : null'></OtherType>
      </li>
      <li v-for='(float, idx) in floats'>
        <OtherType :other='float' :type='idx === 0 ? f : null'></OtherType>
      </li>
      <li v-for='(boolean, idx) in booleans'>
        <OtherType :other='boolean' :type='idx === 0 ? b : null'></OtherType>
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
      a: 'array',
      h: 'hash',
      s: 'string',
      f: 'float',
      i: 'integer',
      b: 'boolean',
      sy: 'symbol',
      arrays: [],
      hashes: [],
      strings: [],
      integers: [],
      floats: [],
      symbols: [],
      booleans: [],
      name: '',
      boxWidth: 90,
      borderColor: '#37414f'
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
      let localStrings = []
      let localSymbols = []
      let localBooleans = []
      let localIntegers = []
      let localFloats = []
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
          case typeof this.stacks[v] === 'string':
            if (this.stacks[v].slice(this.stacks[v].length-3) === 'SYM') {
              localSymbols.push({[v]: this.stacks[v]})
            } else {
              localStrings.push({[v]: this.stacks[v]})
            }
            break;
          case typeof this.stacks[v] === 'number':
            if (this.stacks[v] % 1 === 0) {
              localIntegers.push({[v]: this.stacks[v]})
            } else {
              localFloats.push({[v]: this.stacks[v]})
            }
            break;
          case typeof this.stacks[v] === 'boolean':
              localBooleans.push({[v]: this.stacks[v]})
            break;
          default:
            return null
        }

      })
      this.arrays = localArrays
      this.hashes = localHashes
      this.strings = localStrings
      this.symbols = localSymbols
      this.booleans = localBooleans
      this.integers = localIntegers
      this.floats = localFloats

    },
    getWidth: function () {
      this.boxWidth += (this.numWidth+1)*2
    },
    changeBorder: function  () {
      this.borderColor = this.isCurrentFrame ? '#a8b3c2' : '#37414f'
    }
  }
}
</script>
