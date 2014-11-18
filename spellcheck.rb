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

def extra_letter
  @misspelled.each do |word|
    n = 0
    current = word.dup
    (word.length - 1).times do
      word.slice!(n)
      candidate = word
      check_dictionary(candidate, current)
      word = current.dup
      n += 1
    end
  end
end

def letter_swap
  @misspelled.each do |word|
    n = 0
    current = word.dup
    (word.length - 1).times do
      word[n], word[n+1] = word[n+1], word[n]
      candidate = word.dup
      check_dictionary(candidate, current)
      word[n+1], word[n] = word[n], word[n+1]
      n+= 1
    end
  end
end

def add_letter
  @misspelled.each do |word|
    n = 0
    current = word.dup
    (word.length + 1).times do
      ("a".."z").each do |letter|
        word = current.dup
        candidate = word.insert(n, letter)
        # binding.pry
        check_dictionary(candidate, current)
      end
      n += 1
    end
  end
end

def check_dictionary(candidate, current)
  if @dictionary[candidate] != nil && @corrections[current] != nil
    @corrections[current].push(candidate)
  elsif @dictionary[candidate] != nil && @corrections[current] == nil
    @corrections[current] = [candidate]
  end
end

def correct(sentence)
  build_dictionary('lotsowords.txt')
  @misspelled = []
  @corrections = {}

  sentence.downcase.split(/[^a-zA-Z'-]/).each do |word|
    @misspelled << word if @dictionary[word] == nil
  end

  letter_swap
  add_letter
  extra_letter
  p @corrections
end

input = ARGV.join(" ")
correct(input)
