# typed: strict
# frozen_string_literal: true

require "erubis"

module Rulers
  class Controller
    extend T::Sig

    Locals = T.type_alias { T::Hash[String, T.untyped] }
    RenderOptions = T.type_alias { { action: Symbol } }

    sig { params(env: Rulers::Env).void }
    def initialize(env)
      @env = env
      @_responded = T.let(false, T::Boolean)
    end

    sig { returns(Env) }
    attr_reader :env

    sig { params(action: Symbol).returns(String) }
    def render(action:)
      filename = File.join("app", "views", controller_name, "#{action}.html.erb")
      template = File.read(filename)
      eruby = Erubis::Eruby.new(template)

      locals = build_locals

      @_responded = true

      eruby.result(locals)
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

    sig { params(action: T.any(String, Symbol)).returns(String) }
    def _process(action)
      result = send(action)

      result = render(action: action.to_sym) unless @_responded

      result
    end

    private

    sig { returns(Locals) }
    def build_locals
      locals = { controller_name: controller_name }

      instance_variables.each do |instance_variable|
        locals[instance_variable] = instance_variable_get(instance_variable)
      end

      locals
    end
  end
end
