require './lib/request_formatting'

class Game
  attr_reader :guess_counter, :formater, :path_checker

  def initialize(server)
    @server =         server
    @number =         5
    @guess_counter =  0
    @formater =       RequestFormatting.new
  end

  def run
    loop do
      request_lines = @server.client_request
      debug = formater.request_output(request_lines)
      path = formater.request_path(request_lines)
      @path_checker =  PathChecker.new(path)

      if game_post_request(request_lines)
        request_body_lines = @server.game_client_request
      end

      if game_get_request(request_lines)
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
      elsif game_post_request(request_lines)
        @guess = request_body_lines.last.to_i
        @guess_counter += 1
        number_guesses_output = "You have made #{guess_counter} guesses."
        @server.game_server_response
      end
    end
  end

  def game_get_request(request_lines)
    path_checker.game? && formater.verb(request_lines) == "GET"
  end

  def game_post_request(request_lines)
    path_checker.game? && formater.verb(request_lines) == "POST"
  end
end
