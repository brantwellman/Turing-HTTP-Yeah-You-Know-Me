require 'minitest'
require 'minitest/autorun'
require './lib/server_decorator'
require './lib/server'

class ServerDecoratorTest < Minitest::Test

  def test_gets_path_from_request_lines
    serve_dec = ServerDecorator.new(Server.new(9292))
    request_lines = ["GET /word HTTP/1.1",
 "Host: 127.0.0.1:9292",
 "Connection: keep-alive",
 "Cache-Control: max-age=0",
 "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
 "Upgrade-Insecure-Requests: 1",
 "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_10_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/46.0.2490.80 Safari/537.36",
 "Accept-Encoding: gzip, deflate, sdch",
 "Accept-Language: en-US,en;q=0.8"]
  expected = "/word"
  assert_equal expected, serve_dec.request_path(request_lines)
  end
end
