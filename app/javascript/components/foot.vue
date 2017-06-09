<template>
  <nav class='footer'>
    <div class="examples">
      <h4>Examples</h4>
      <button type="button" v-on:click="updateCode(mergeSort)">Merge Sort</button>
      <button type="button" v-on:click="updateCode(caesar_cipher)">Caesar Cipher</button>
      <button type="button" v-on:click="updateCode(check_anagram)">Check Anagram</button>
    </div>
    <ul class="contact">
      <h4>Contact</h4>
      <li>Bryant</li>
      <li>Audrey</li>
    </ul>
    <ul>
      <li>Inspired by Python Tutor</li>
      <li>Future plans to do this</li>
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
  return get_freq(str1.downcase) == get_freq(str2.downcase)
end

check_anagram("brite", "tribe")`
    }
  },
  methods: {
    updateCode: function(userInput) {
      this.$emit('updateCode', userInput)
    }
  }
}
</script>
