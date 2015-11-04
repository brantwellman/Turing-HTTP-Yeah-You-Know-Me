require 'minitest'
require 'minitest/autorun'
require './lib/responser'
require 'date'


class ResponserTest < Minitest::Test
  def test_responds_with_debug_info_for_root_path
    responser = Responser.new

    request_lines = ["GET / HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    expected = "<pre>Verb: GET\nPath: /\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"

    assert_equal expected, responser.generate_response("/", request_lines, 0, 0)
  end

  def test_responds_with_hello_info_for_hello_path_on_request_zero
    responser = Responser.new
    request_lines = ["GET /hello HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    expected = "Hello World (0)\n<pre>Verb: GET\nPath: /hello\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"

    assert_equal expected, responser.generate_response("/hello", request_lines, 0, 0)
  end

  def test_responds_with_datetime_info_for_datetime_path
    responser = Responser.new
    request_lines = ["GET /datetime HTTP/1.1",
                     "Host: 127.0.0.1:9292",
                     "Connection: keep-alive",
                     "Cache-Control: max-age=0",
                     "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
                     "Upgrade-Insecure-Requests: 1",
                     "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
                     "Accept-Encoding: gzip, deflate, sdch",
                     "Accept-Language: en-US,en;q=0.8"]

    date_time = DateTime.now.strftime('%H:%M%p on %A, %B %d, %Y')

    expected = "#{date_time}\n<pre>Verb: GET\nPath: /datetime\nProtocol: HTTP/1.1\nHost: 127.0.0.1\nPort: 9292\nOrigin: 127.0.0.1\nAccept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8\n</pre>"

    assert_equal expected, responser.generate_response("/datetime", request_lines, 0, 0)
  end
end
