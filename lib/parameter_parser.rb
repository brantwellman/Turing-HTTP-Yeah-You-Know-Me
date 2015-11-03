class ParameterParser
  def url_splitter(path)
    parameters = path.split("?")[1].split("&")
    parameters.map do |param|
      param.split("=")[1]
    end
  end

  def words_check(path)
    url_splitter(path)
  end
end
