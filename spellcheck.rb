def build_dictionary(source)
  word_hash, @dictionary = {}, {}

  File.open(source, 'r').read.downcase.split(/[^a-zA-Z'-]/).each do |word|
    word_hash[word] == nil ? word_hash[word] = 1 : word_hash[word] += 1
  end

  word_hash.sort_by { |k, v| v }.reverse.each { |i| @dictionary[i[0]] = i[1] }
end

def extra_letter
  @misspelled.each do |word|
    current, n = word.dup, 0
    (word.length - 1).times do
      word.slice!(n)
      candidate, word = word, current.dup
      check_dictionary(candidate, current)
      n += 1
    end
  end
end

def letter_swap
  @misspelled.each do |word|
    current, n = word.dup, 0
    (word.length - 1).times do
      word[n], word[n+1] = word[n+1], word[n]
      candidate, word[n+1], word[n] = word.dup, word[n], word[n+1]
      check_dictionary(candidate, current)
      n+= 1
    end
  end
end

def add_letter
  @misspelled.each do |word|
    current, n = word.dup, 0
    (word.length + 1).times do
      ("a".."z").each do |letter|
        word = current.dup
        candidate = word.insert(n, letter)
        check_dictionary(candidate, current)
      end
      n += 1
    end
  end
end

def check_dictionary(candidate, current)
  freq = @dictionary[candidate]

  if !@dictionary[candidate].nil? && !@corrections[current].nil?
    @corrections[current] << [candidate, freq]
  elsif !@dictionary[candidate].nil? && @corrections[current].nil?
    @corrections[current] = [[candidate, freq]]
  end
end

def return_corrections
  new_sentence = []

  @corrections.each do |k, v|
    v.sort_by! { |array| -array[1] }
  end

  @sentence.split(' ').each do |word|
    if @corrections[word] != nil
      new_sentence << @corrections[word].max[0]
    else
      new_sentence << word
    end
  end

  puts "Original Sentence: #{@sentence}"
  puts "Corrected Sentence: #{new_sentence.join(' ')}"
end

def correct(sentence)
  build_dictionary('lotsowords.txt')
  @sentence, @misspelled, @corrections = sentence, [], {}

  @sentence.downcase.split(/[^a-zA-Z'-]/).each do |word|
    @misspelled << word if @dictionary[word] == nil
  end

  letter_swap
  add_letter
  extra_letter
  return_corrections
end

correct(ARGV.join(" "))
