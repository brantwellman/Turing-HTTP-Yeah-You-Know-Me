class PathChecker
  def initialize(path_string)
    @path_string = path_string
  end

  def root?
    @path_string == "/"
  end

  def hello?
    @path_string == "/hello"
  end

  def datetime?
    @path_string == "/datetime"
  end

  def shutdown?
    @path_string == "/shutdown"
  end

  def word_search?
    @path_string.start_with?("/word_search?")
  end

  def start_game?
    @path_string == "/start_game"
  end

  def game?
    @path_string.start_with?("/game")
  end
end
