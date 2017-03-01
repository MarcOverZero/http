require 'socket'
require 'pry'
require '.lib/response'

class HTTP
  attr_reader  :tcp_server :request_lines :verb, :path, :protocol, :port, :origin, :accept
  def initialize
    @tcp_server = TCPServer.new(9292)
    @request_lines = []
    @verb = verb
    @path = path
    @protocol = protocol
    @host = host
    @port = port
    @origin = origin
    @accept = accept
    #future variabls => counters (refresh & guess), connection break

  end


    client = tcp_server.accept

    puts "Ready for a request"
    while line = client.gets and !line.chomp.empty?
      request_lines << line.chomp
    end


    puts "Got this request:"
    puts request_lines.inspect

    puts "Sending response."
    output = "<html><head></head><body>#{response}</body></html>"
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
      port_plus = request_lines[1].split(" ")[1]
      @port = port_plus.split(":")[1]
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
