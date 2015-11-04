require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/parameter_parser'

class ParameterParserTest < Minitest::Test
  def test_parameters_no_word
    parameter_parser = ParameterParser.new
    path = "http://127.0.0.1:9292/word_search"
    expected = []
    assert_equal expected, parameter_parser.parameters(path)
  end

  def test_parameters_one_word
    parameter_parser = ParameterParser.new
    path = "http://127.0.0.1:9292/word_search?word=pizza"
    expected = ["pizza"]
    assert_equal expected, parameter_parser.parameters(path)
  end

  def test_parameters_two_words
    parameter_parser = ParameterParser.new
    path = "http://127.0.0.1:9292/word_search?word=pizza&word=cat"
    expected = ["pizza", "cat"]
    assert_equal expected, parameter_parser.parameters(path)
  end

  def test_parameters_three_words
    parameter_parser = ParameterParser.new
    path = "http://127.0.0.1:9292/word_search?word=pizza&word=cat&word=dog"
    expected = ["pizza", "cat", "dog"]
    assert_equal expected, parameter_parser.parameters(path)
  end
end
