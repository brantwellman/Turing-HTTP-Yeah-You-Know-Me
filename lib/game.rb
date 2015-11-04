require 'pry'

class Game
  attr_reader :guess_counter

  def initialize(server)
    @server = server
    @number = 5
    @guess_counter = 0
    parser = ParameterParser.new
  end

  def run
    request_lines = @server.client_request
    # binding.pry
    # unless request_lines.first == "GET /favicon.ico HTTP/1.1"
    #   # request_counter += 1
    # end
    debug = @server.request_output(request_lines)
    path = @server.request_path(request_lines)
    path_checker = PathChecker.new(path)
    if path_checker.game? && @server.verb(request_lines) == "GET"
      response = "You have made #{guess_counter} guesses."
      @server.server_response(response)
    elsif path_checker.game? && @server.verb(request_lines) == "POST"
      guess = parser.words_check(path)[0].to_i
      @guess_counter += 1
      number_guesses_output = "You have made #{guess_counter} guesses."
      if guess > @number
        response = "Too high."
      elsif guess < @number
        response = "Too low."
      else
        response = "Correct!"
      end
      response += "\n" + number_guesses_output
      @server.game_server_response(response)
    end

  end




end


# access server object from iteration which is already open

# POST to /start_game will start the game and respond with "Good Luck!"
# GET to /game responds with 1) How many guess have been made 2) What the guess was and whether it was high, low, or correct
# POS to /game includes parameter named 'guess' sends user a direct response automatically initiating the GET to /game response above
  # This loop continues until guess is correct - break out of server
