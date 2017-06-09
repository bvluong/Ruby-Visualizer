<template>
  <nav class='footer'>
    <div class="examples">
      <h3 class='footer-label'>Examples</h3>
      <button type="button" v-on:click="updateCode(mergeSort)">Merge Sort</button>
      <button type="button" v-on:click="updateCode(caesar_cipher)">Caesar Cipher</button>
      <button type="button" v-on:click="updateCode(check_anagram)">Check Anagram</button>
    </div>
    <section class="">
      <h3 class='footer-label'>Note</h3>
      <ul>
        <li>Inspired by Python Tutor</li>
        <li>Future plans to do this</li>
      </ul>
    </section>
    <ul class="contact">
      <h3 class='footer-label'>Contact</h3>
      <li>
        <h4>Bryant</h4>
        <section class="contact-icons">
          <a href="https://github.com/bvluong" target="_blank">
            <i class="fa fa-github" id="fa-contact" aria-hidden="true"></i>
          </a>
          <a href="https://www.linkedin.com/in/bryant-luong/" target="_blank">
            <i class="fa fa-linkedin" id="fa-contact" aria-hidden="true"></i>
          </a>
          <a href="mailto:bryantvinluong@gmail.com?Subject=Hello" target="_blank">
            <i class="fa fa-envelope-o" id="fa-contact" aria-hidden="true"></i>
          </a>
        </section>
      </li>
      <li>
        <h4>Audrey</h4>
        <section class="contact-icons">
          <a href="https://github.com/bvluong" target="_blank">
            <i class="fa fa-github" id="fa-contact" aria-hidden="true"></i>
          </a>
          <a href="https://www.linkedin.com/in/bryant-luong/" target="_blank">
            <i class="fa fa-linkedin" id="fa-contact" aria-hidden="true"></i>
          </a>
          <a href="mailto:bryantvinluong@gmail.com?Subject=Hello" target="_blank">
            <i class="fa fa-envelope-o" id="fa-contact" aria-hidden="true"></i>
          </a>
        </section>
      </li>
    </ul>
  </nav>
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
  return get_freq(str1.downcase) == get_freq(str2.downcase)
end

check_anagram("brite", "tribe")`
    }
  }
}
</script>
