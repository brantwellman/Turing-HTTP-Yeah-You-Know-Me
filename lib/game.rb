require './lib/request_formatting'
require 'pry'

class Game
  attr_reader :guess_counter, :parser, :formater

  def initialize(server)
    @server =        server
    @number =        5
    @guess_counter = 0
    @parser =        ParameterParser.new
    @formater =      RequestFormatting.new
  end

  def run
    loop do
      request_lines = @server.client_request
      debug = formater.request_output(request_lines)
      path = formater.request_path(request_lines)
      path_checker = PathChecker.new(path)

      if path_checker.game? && formater.verb(request_lines) == "GET"
        number_guesses_output = "You have made #{guess_counter} guesses."

        if @guess_counter > 0
          if @guess > @number
            response = "Too high."
          elsif @guess < @number
            response = "Too low."
          else
            response = "Correct!"
          end
          response += "\n" + number_guesses_output
        end

        @server.server_response(response)
        break if response == "Correct!\nYou have made #{guess_counter} guesses."

      elsif path_checker.game? && formater.verb(request_lines) == "POST"
        @guess = parser.parameters(path)[0].to_i
        @guess_counter += 1
        number_guesses_output = "You have made #{guess_counter} guesses."

        @server.game_server_response("hey now redirect")
      end
    end
  end
end
