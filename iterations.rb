require './lib/server'
require './lib/request_formatting'
require './lib/path_checker'
require './lib/parameter_parser'
require './lib/word_search'
require './lib/game'
require 'date'
require 'pry'

hello_server = Server.new(9292)
formater = RequestFormatting.new

request_counter = 0
hello_counter = 0

loop do
  request_lines = hello_server.client_request
  unless request_lines.first == "GET /favicon.ico HTTP/1.1"
    request_counter += 1
  end

  # response = Responser.new.generate_response(a, b, c, d)

  path = formater.request_path(request_lines)
  path_checker = PathChecker.new(path)
  debug = formater.request_output(request_lines)

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
    parser = ParameterParser.new
    words = parser.parameters(path)
    words_check = WordSearch.new
    response = words_check.word_output(words)

    response += debug

  elsif path_checker.start_game?
    if formater.verb(request_lines) == "POST"
      # binding.pry
      response = "Good luck!" + debug
      hello_server.server_response(response)
      game = Game.new(hello_server)
      game.run
    else
      response = debug
    end

  elsif path_checker.shutdown?
    response = "Total Requests #{request_counter}"  + "\n" + debug
    hello_server.server_response(response)
    break
  end

  hello_server.server_response(response)
end

hello_server.close_server
