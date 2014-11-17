#!/usr/bin/env ruby
require 'pry'

def build_dictionary(source)
  source = File.open(source, 'r').read.downcase.split(/[^a-zA-Z'-]/)
  word_hash, @dictionary = {}, {}
  source.each do |word|
    word_hash[word] == nil ? word_hash[word] = 1 : word_hash[word] += 1
  end

  word_hash.sort_by { |k, v| v }.reverse.each { |i| @dictionary[i[0]] = i[1] }
end

# def extra_letter
#   words = []
#   @sentence.each { |word| words << word.split('') }
#   words.each do |word|
#     index = 0
#     word.length.times do |n|
#       letter = "a"
#       26.times do
#         check = word.insert(n, letter).join('')
#         @mispelled[check] = word.join('') if @dictionary[check] != nil
#         letter.next!
#       end
#     index += 1 if letter == "z"
#     end
#   end
#   p @mispelled
# end

def letter_swap
  @mispelled.each do |word|
    n = 0
    current = word.dup
    (word.length - 1).times do
      word[n], word[n+1] = word[n+1], word[n]
      candidate = word.dup
      if @dictionary[candidate] != nil && @corrections[current] != nil
        @corrections[current].push(candidate)
      elsif @dictionary[candidate] != nil && @corrections[current] == nil
        @corrections[current] = [candidate]
      end

      word[n+1], word[n] = word[n], word[n+1]
      n+= 1
    end

  end
end
#
# @mispelled = ["wrds"]
# def add_letter
#   candidates = []
#   @mispelled.each do |word|
#     n = 0
#     word.length.times do
#       # binding.pry
#       original = word
#       ("a".."z").each do |letter|
#         word = original
#         candidate = word.insert(n, letter)
#         candidates << candidate if @dictionary[candidate] != nil
#       end
#       n += 1
#     end
#   end
#   # p candidates
# end
#
def correct(sentence)
  build_dictionary('lotsowords.txt')
  @mispelled = []
  @corrections = {}

  sentence.downcase.split(/[^a-zA-Z'-]/).each do |word|
    @mispelled << word if @dictionary[word] == nil
  end

  letter_swap
  # add_letter
  # extra_letter
  p @corrections
end


  # Check if a letter is missing
    # split word into an array of letters
    # insert new letter "x" at the beginning, end, and between each array element
    # check if new word in dictionary
    # iterate through [a-z] and continue checking until a match is found
    # push matches to matches hash with frequency
    # insert new letter "x" at next position and repeat the above steps

  # Return list of possible corrections to mispelled words
    # sort matches array by frequency
    # return input with mispelled word replaced by the most frequent hash word.



input = ARGV.join(" ")
correct(input)
