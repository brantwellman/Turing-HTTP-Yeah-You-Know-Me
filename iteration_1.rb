require "./lib/server"

hello_server = Server.new(9292)

request_lines = hello_server.client_request

response = hello_server.request_output

hello_server.server_response(response)

hello_server.close_server
