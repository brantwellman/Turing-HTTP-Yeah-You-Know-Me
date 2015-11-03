require './lib/server'
require './lib/server_decorator'
require 'date'
require './lib/path_checker'
require './lib/parameter_parser'
require './lib/word_search'

hello_server = ServerDecorator.new(Server.new(9292))

request_counter = 0
hello_counter = 0

loop do
  request_lines = hello_server.client_request
  unless request_lines.first == "GET /favicon.ico HTTP/1.1"
    request_counter += 1
  end

  path = hello_server.request_path(request_lines)
  path_checker = PathChecker.new(path)
  debug = hello_server.request_output(request_lines)

  if path_checker.root?
    response = debug
  elsif path_checker.hello?
    unless request_lines.first == "GET /favicon.ico HTTP/1.1"
      hello_counter += 1
    end
    response = "Hello World (#{hello_counter})" + "\n" + debug
  elsif path_checker.datetime?
    now_time = DateTime.now
    response = now_time.strftime('%H:%M%p on %A, %B %d, %Y')  + "\n" + debug
  elsif path_checker.word_search?
    parse_params = ParameterParser.new
    words = parse_params.words_check(path)
    words_check = WordSearch.new
    response = words_check.word_output(words)

    response += debug
  elsif path_checker.shutdown?
    response = "Total Requests #{request_counter}"  + "\n" + debug
    hello_server.server_response(response)
    break
  end

  hello_server.server_response(response)
end

hello_server.close_server
