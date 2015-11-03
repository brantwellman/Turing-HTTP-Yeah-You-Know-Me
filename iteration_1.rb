require "./lib/server"
require "./lib/server_decorator"

hello_server = ServerDecorator.new(Server.new(9292))

request_lines = hello_server.client_request

response = hello_server.request_output(request_lines)

hello_server.server_response(response)

hello_server.close_server
