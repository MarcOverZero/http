require 'minitest'
require 'minitest/autorun'
require 'faraday'

class ResponseTest < Minitest::Test

  def test_it_respond_for_root
      response = Faraday.get "http://127.0.0.1:9292/"
      assert 
  end


end
