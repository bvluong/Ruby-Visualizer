<template>
  <nav class='footer'>
    <div class="examples">
      <h4>Examples</h4>
      <button type="button" v-on:click="updateCode(mergeSort)">Merge Sort</button>
      <button type="button" v-on:click="updateCode(mergeSort)"></button>
      <button type="button" v-on:click="updateCode(mergeSort)"></button>
    </div>
    <ul class="contact">
      <h4>Contact</h4>
      <li>Bryant</li>
      <li>Audrey</li>
    </ul>
  </nav>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  computed: {

  },
  data: function () {
    return {
      mergeSort:`def mergesort(list)
  return list if list.size <= 1
  mid   = list.size / 2
  left  = list[0, mid]
  right = list[mid, list.size]
  merge(mergesort(left), mergesort(right))
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    if left.first <= right.first
      sorted << left.shift
    else
      sorted << right.shift
    end
  end
  sorted.concat(left).concat(right)
end
mergesort([7,2,4,1])`
    }
  },
  methods: {
    updateCode: function(userInput) {
      this.$emit('updateCode', userInput)
    }
  }
}
</script>
