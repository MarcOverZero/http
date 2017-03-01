require 'socket'
require 'pry'

class GETdone
  attr_reader  :verb, :path, :protocol, :port, :origin, :accept
    tcp_server = TCPServer.new(9292)
    client = tcp_server.accept

    puts "Ready for a request"
    request_lines = []
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end


    puts "Got this request:"
    puts request_lines.inspect

    puts "Sending response."
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    output = "<html><head></head><body>'Hello'</body></html>"
    headers = ["http/1.1 200 ok",
              "date: #{Time.now.strftime('%a, %e %b %Y %H:%M:%S %z')}",
              "server: ruby",
              "content-type: text/html; charset=iso-8859-1",
              "content-length: #{output.length}\r\n\r\n"].join("\r\n")
    client.puts headers
    client.puts output

    puts ["Wrote this response:", headers, output].join("\n")
    client.close
    puts "\nResponse complete, exiting."

    def parse_request(request_lines)
      @verb = request_lines[0].split("/")[0]
      @path = request_lines[0].split(" ")[1]
      @protocol = request_lines[0].split(" ")[2]
      @host = request_lines[1]  #self defining, no additional string needed
      root_port = request_lines[1].split(" ")[1]
      @port = root_port.split(":")[1]
      @origin = root_port.split(":")[0]
      @accept = request_lines[6]  #self defining, no additional string needed
    end

    def parsed_root_header_string
      %Q[
        <pre>
        "Verb:#{@verb}
         Path: #{@path}
         Protocol: #{@protocol}
         #{@host}
         Port: #{@port}
         Origin: #{@origin}
         #{@accept}"
        </pre>
        ]
    end


end

  binding.pry
  '---'
