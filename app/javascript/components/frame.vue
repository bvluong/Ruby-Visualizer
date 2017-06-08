<template>
  <ul>
    <li>
      {{getVariables}}
    </li>
    <li v-for='arr in arrays'>
      {{arr}}
    </li>
    <li v-for='hash in hashes'>

      {{hash}}
    </li>
    <li v-for='other in otherTypes'>

      {{other}}
    </li>
  </ul>
</template>




<script>
export default {
  data: function () {
    return {
      arrays: [],
      hashes: [],
      otherTypes: [],
      stacksData: this.stacks ? this.stacks : 'no stacks'
    }
  },
  props: ['stacks'],
  computed: {
    getVariables: function () {
      let vars = Object.keys(this.stacks)
      let localArrays = []
      let localHashes = []
      let localOtherTypes = []
      vars.forEach((v) => {
        switch (true){
          case this.stacks[v] instanceof Array:
            localArrays.push({[v]: this.stacks[v]})
            break;
          case this.stacks[v] instanceof Object:
            localHashes.push({[v]: this.stacks[v]})
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
