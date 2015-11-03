# <pre>
# Verb: POST
# Path: /
# Protocol: HTTP/1.1
# Host: 127.0.0.1
# Port: 9292
# Origin: 127.0.0.1
# Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
# </pre>

require "./lib/server"

hello_server = Server.new(9292)

request_lines = hello_server.client_request
puts request_lines
# hello_server.client_request

# verb = request_lines[0].split(" ")[0]
# path = request_lines[0].split(" ")[1]
# protocol = request_lines[0].split(" ")[2]
# host = request_lines[1].split(":")[1].strip
# port = request_lines[1].split(":")[2]
# origin = request_lines[1].split(":")[1].strip
# accept = request_lines[4].split(": ")[1]
#
# response = "<pre>" + "Verb: #{verb}\nPath: #{path}\nProtocol: #{protocol}\nHost: #{host}\nPort: #{port}\nOrigin: #{origin}\nAccept: #{accept}\n"  + "</pre>"

response = hello_server.request_output
hello_server.server_response(response)

hello_server.close_server
