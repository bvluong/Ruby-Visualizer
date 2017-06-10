<template>
  <header>
    <h3>Ruby Visualizer</h3>
      <section class="examples">
        <h3 class='footer-label'>Examples</h3>
        <button type="button" v-on:click="updateCode(mergeSort)">Merge Sort</button>
        <button type="button" v-on:click="updateCode(caesar_cipher)">Caesar Cipher</button>
        <button type="button" v-on:click="updateCode(check_anagram)">Check Anagram</button>
      </section>
  </header>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  methods: {
    updateCode: function(userInput) {
      this.$emit('updateCode', userInput)
    }
  },
  data: function () {
    return {
      mergeSort: `def mergesort(list)
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
mergesort([7,2,4,1])`,
    caesar_cipher:`def caesar_cipher(str, shift)
letters = ("a".."z").to_a

encoded_str = ""
str.each_char do |char|
  if char == " "
    encoded_str << " "
    next
  end

  old_idx = letters.find_index(char)
  new_idx = (old_idx + shift) % letters.count

  encoded_str << letters[new_idx]
end

encoded_str
end

caesar_cipher("caesar cipher",8)`,
    check_anagram:`def get_freq(str)
  freq = Hash.new(0)
  str.each_char do |chr|
    freq[chr] += 1
  end
  freq
end

def check_anagram(str1, str2)
  str1_hash = get_freq(str1.downcase)
  str2_hash = get_freq(str2.downcase)
  return str1_hash == str2_hash
end

check_anagram("brite", "tribe")`
    }
  }
}
</script>

<style scoped>
  /*Style does not work*/
  header {
    height: 200px;
    width: 100%;
    border: 1px solid blue;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

</style>
