# typed: strict
# frozen_string_literal: true

require "erubis"

module Rulers
  class Controller
    extend T::Sig

    sig { params(env: Rulers::Env).void }
    def initialize(env)
      @env = env
    end

    sig { returns(Env) }
    attr_reader :env

    sig { params(view_name: Symbol, locals: T::Hash[Symbol, T.untyped]).returns(String) }
    def render(view_name, locals = {})
      filename = File.join("app", "views", controller_name, "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubis::Eruby.new(template)

      eruby.result(locals.merge(env: env))
    end

    sig { returns(String) }
    def controller_name
      self.class.to_s.gsub(/Controller$/, "").to_underscore
    end

    sig { returns(T::Boolean) }
    def get?
      env["REQUEST_METHOD"] == "GET"
    end

    sig { returns(T::Boolean) }
    def post?
      env["REQUEST_METHOD"] == "POST"
    end
  end
end
