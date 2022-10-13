# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/object"

module Rulers
  class Application
    def call(env)
      [200, {'content-type' => 'text/html'}, ["Hello from Ruby on Rulers!"]]
    end
  end
end
