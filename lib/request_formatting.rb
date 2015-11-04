require 'delegate'

class RequestFormatting
  def request_output(request_lines)
    verb = request_lines[0].split(" ")[0]
    path = request_lines[0].split(" ")[1]
    protocol = request_lines[0].split(" ")[2]
    host = request_lines.select {|line| line.start_with?("Host:") }[0].split(":")[1].strip
    port = request_lines.select {|line| line.start_with?("Host:") }[0].split(":")[2]
    origin = host

    accept = request_lines.select {|line| line.start_with?("Accept:") }[0]

    "<pre>" + "Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{origin}\n#{accept}\n"  + "</pre>"
  end

  def verb(request_lines)
    request_lines[0].split(" ")[0]
  end

  def request_path(request_lines)
    request_lines[0].split(" ")[1]
  end
end
