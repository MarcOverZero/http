class Response

  attr_reader :hello :hello_world
  @hello = hello
  @hello_world= hello_world

  def messages
    
    response = "<pre>" + request_lines.join("\n") + "</pre>"
    hello = "Hello"
    hello_world = "Hello World!"
  end

end
