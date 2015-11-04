require_relative 'request_formatting'
require_relative 'path_checker'
require './lib/parameter_parser'
require './lib/word_search'

class Responser
  def initialize
    @formatter = RequestFormatting.new
    # @response_strings = ResponseStrings.new
  end

  def generate_response(request_lines, hello_counter, request_counter)
    path = @formatter.request_path(request_lines)
    path_checker = PathChecker.new(path)
    debug = generate_debug(request_lines)

    if path_checker.root?
      response = debug
      # response = @response_strings.root
    elsif path_checker.hello?
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
      if @formatter.verb(request_lines) == "POST"
        response = "Good luck!" + debug
      else
        response = debug
      end
    elsif path_checker.shutdown?
      response = "Total Requests #{request_counter}"  + "\n" + debug
    end

    response
  end

  def generate_debug(request_lines)
    @formatter.request_output(request_lines)
  end
end
