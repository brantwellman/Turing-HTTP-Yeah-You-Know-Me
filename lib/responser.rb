require_relative 'request_formatting'
require_relative 'path_checker'

class Responser
  def initialize
    @formatter = RequestFormatting.new
    # @response_strings = ResponseStrings.new
  end

  def generate_response(path, request_lines, hello_counter, request_counter)
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
    end

    response
  end

  def generate_debug(request_lines)
    @formatter.request_output(request_lines)
  end
end
