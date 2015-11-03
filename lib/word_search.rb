class WordSearch
  def initialize
    @dictionary = File.read("/usr/share/dict/words").split("\n")
  end

  def is_word?(word_string)
    @dictionary.include?(word_string)
  end

  def word_output(words)
    check_words_for_output = words.map do |word|
      if is_word?(word)
        "#{word} is a known word."
      else
        "#{word} is not a known word."
      end
    end
    output = "<pre>" + check_words_for_output.join("\n") + "</pre>"
  end
end
#
# word_search = WordSearch.new
# puts word_search.is_word?("pizz")
