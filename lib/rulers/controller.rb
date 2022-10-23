# typed: strict
# frozen_string_literal: true

require "erubis"

module Rulers
  class Controller
    extend T::Sig

    Locals = T.type_alias { T::Hash[String, T.untyped] }

    sig { params(env: Rulers::Env).void }
    def initialize(env)
      @env = env
    end

    sig { returns(Env) }
    attr_reader :env

    sig { params(view_name: Symbol, locals: Locals).returns(String) }
    def render(view_name, locals = {})
      filename = File.join("app", "views", controller_name, "#{view_name}.html.erb")
      template = File.read(filename)
      eruby = Erubis::Eruby.new(template)

      eruby.result(supplement_locals(locals))
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

    private

    sig { params(locals: Locals).returns(Locals) }
    def supplement_locals(locals)
      locals = locals.merge(controller_name: controller_name)

      instance_variables.each do |instance_variable|
        locals[instance_variable] = instance_variable_get(instance_variable)
      end

      locals
    end
  end
end
