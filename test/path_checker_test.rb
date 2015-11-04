require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/path_checker'

class PathCheckerTest < Minitest::Test
  def test_refute_empty_string_root
    string = ""
    path_checker = PathChecker.new(string)
    refute path_checker.root?
  end

  def test_refute_empty_string_hello
    string = ""
    path_checker = PathChecker.new(string)
    refute path_checker.hello?
  end

  def test_refute_empty_string_datetime
    string = ""
    path_checker = PathChecker.new(string)
    refute path_checker.datetime?
  end

  def test_refute_empty_string_shutdown
    string = ""
    path_checker = PathChecker.new(string)
    refute path_checker.shutdown?
  end

  def test_refute_empty_string_word_search
    string = ""
    path_checker = PathChecker.new(string)
    refute path_checker.word_search?
  end

  def test_assert_root
    string = "/"
    path_checker = PathChecker.new(string)
    assert path_checker.root?
  end

  def test_assert_hello
    string = "/hello"
    path_checker = PathChecker.new(string)
    assert path_checker.hello?
  end

  def test_assert_datetime
    string = "/datetime"
    path_checker = PathChecker.new(string)
    assert path_checker.datetime?
  end

  def test_assert_shutdown
    string = "/shutdown"
    path_checker = PathChecker.new(string)
    assert path_checker.shutdown?
  end

  def test_assert_word_search
    string = "/word_search?"
    path_checker = PathChecker.new(string)
    assert path_checker.word_search?
  end

  def test_refute_capital_hello
    string = "/Hello"
    path_checker = PathChecker.new(string)
    refute path_checker.hello?
  end

  def test_refute_word_search_word
    string = "/word"
    path_checker = PathChecker.new(string)
    refute path_checker.word_search?
  end

  def test_refute_word_search_pizza
    string = "/word_search_pizza"
    path_checker = PathChecker.new(string)
    refute path_checker.word_search?
  end
end
