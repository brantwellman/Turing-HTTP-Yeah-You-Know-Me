require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/request_formatting'

class RequestFormattingTest < Minitest::Test
  def test_request_output_without_cache_control
    formatter = RequestFormatting.new
    request_lines = ["GET /word_search?word=pizz&word2=dog HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "<pre>Verb: GET\nPath: /word_search?word=pizz&word2=dog\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"
      assert_equal expected, formatter.request_output(request_lines)
  end

  def test_request_output_with_cache_control
    formatter = RequestFormatting.new
    request_lines = ["GET /word_search?word=pizz&word2=dog HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "<pre>Verb: GET\nPath: /word_search?word=pizz&word2=dog\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"
      assert_equal expected, formatter.request_output(request_lines)
  end

  def test_request_path_root
    formatter = RequestFormatting.new
    request_lines = ["GET / HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "/"
      assert_equal expected, formatter.request_path(request_lines)
  end

  def test_request_path_hello
    formatter = RequestFormatting.new
    request_lines = ["GET /hello HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "/hello"
      assert_equal expected, formatter.request_path(request_lines)
  end

  def test_request_path_datetime
    formatter = RequestFormatting.new
    request_lines = ["GET /datetime HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "/datetime"
      assert_equal expected, formatter.request_path(request_lines)
  end

  def test_request_path_shutdown
    formatter = RequestFormatting.new
    request_lines = ["GET /shutdown HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "/shutdown"
      assert_equal expected, formatter.request_path(request_lines)
  end

  def test_request_path_word_search
    formatter = RequestFormatting.new
    request_lines = ["GET /word_search?word=pizz&word2=dog HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "/word_search?word=pizz&word2=dog"
      assert_equal expected, formatter.request_path(request_lines)
  end

  def test_verb_get
    formatter = RequestFormatting.new
    request_lines = ["GET /word_search?word=pizz&word2=dog HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "GET"
      assert_equal expected, formatter.verb(request_lines)
  end

  def test_verb_post
    formatter = RequestFormatting.new
    request_lines = ["POST /start_game HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]
      expected = "POST"
      assert_equal expected, formatter.verb(request_lines)
  end
end
