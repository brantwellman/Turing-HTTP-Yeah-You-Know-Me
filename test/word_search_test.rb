require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/word_search'

class WordSearchTest < Minitest::Test
  def test_empty_string_is_not_a_word
    word_search = WordSearch.new
    refute word_search.is_word?("")
  end

  def test_is_a_word
    word_search = WordSearch.new
    assert word_search.is_word?("dog")
    assert word_search.is_word?("cat")
    assert word_search.is_word?("hamster")
  end

  def test_is_not_a_word
    word_search = WordSearch.new
    refute word_search.is_word?("pizz")
    refute word_search.is_word?("pencily")
    refute word_search.is_word?("dalek")
  end

  def test_word_output_empty_string
    word_search = WordSearch.new
    words = [""]
    assert_equal "<pre> is not a known word.</pre>", word_search.word_output(words)
  end

  def test_word_output_one_known_word
    word_search = WordSearch.new
    words = ["dog"]
    assert_equal "<pre>dog is a known word.</pre>", word_search.word_output(words)
  end

  def test_word_output_one_unknown_word
    word_search = WordSearch.new
    words = ["dalek"]
    assert_equal "<pre>dalek is not a known word.</pre>", word_search.word_output(words)
  end

  def test_word_output_1known_1unknown_words
    word_search = WordSearch.new
    words = ["dog", "dalek"]
    assert_equal "<pre>dog is a known word.\ndalek is not a known word.</pre>", word_search.word_output(words)
  end

  def test_word_output_three_known_words
    word_search = WordSearch.new
    words = ["dog", "cat", "bird"]
    assert_equal "<pre>dog is a known word.\ncat is a known word.\nbird is a known word.</pre>", word_search.word_output(words)
  end
end
