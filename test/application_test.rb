# typed: true
# frozen_string_literal: true

require_relative "test_helper"

class TestController < Rulers::Controller
  def index; end
end

class TestApp < Rulers::Application
end

class RulersAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    TestApp.new
  end

  def test_request
    get "/test/index"
    body = last_response.body

    assert last_response.ok?
    assert body["Hello"]
  end
end
