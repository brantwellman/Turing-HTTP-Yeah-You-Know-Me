class ParameterParser
  def parameters(path)
    if path.split("?").length == 1
      return []
    else
      parameters = path.split("?")[1].split("&")
      parameters.map do |param|
        param.split("=")[1]
      end
    end
  end
end
