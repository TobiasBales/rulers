# frozen_string_literal: true

require "rulers/version"
require "rulers/array"
require "rulers/object"
require "rulers/routing"

module Rulers
  class Application
    def call(env)
      if env['PATH_INFO'] == '/favicon.ico'
        return [404, {'content-type' => 'text/html'}, []]
      end

      begin
        klass, action = get_controller_and_action(env)
      rescue NameError => e
        return [404, {'content-type' => 'text/html'}, ["There is no controller named \"#{klass&.capitalize}Controller\""]]
      end
      controller = klass.new(env)

      response = controller.send(action)

      [200, {'content-type' => 'text/html'}, [response]]
    end
  end

  class Controller
    def initialize(env)
      @env = env
    end

    attr_reader :env

    def get?
      env["REQUEST_METHOD"] == "GET"
    end

    def post?
      env["REQUEST_METHOD"] == "POST"
    end
  end
end
