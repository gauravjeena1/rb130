class Anagram
  
  def initialize(word)
    @word = word
  end

  def match(words)
    sorted = @word.downcase.chars.sort
    
    words.select do |input|
      compare = input.downcase.chars.sort
      input if compare == sorted && @word != input.downcase
    end
  end
end
