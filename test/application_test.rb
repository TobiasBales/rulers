# typed: true
# frozen_string_literal: true

require_relative "test_helper"

class TestApp < Rulers::Application
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/"
    body = last_response.body

    assert last_response.ok?
    assert body["Hello"]
  end
end
