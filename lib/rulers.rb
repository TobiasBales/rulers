# typed: strict
# frozen_string_literal: true

require "sorbet-runtime"
require "rulers/version"
require "rulers/array"
require "rulers/object"
require "rulers/string"
require "rulers/auto_loading"
require "rulers/routing"
require "rulers/controller"

module Rulers
  extend T::Sig

  Env = T.type_alias { T::Hash[String, T.any(String, Integer)] }
  StatusCode = T.type_alias { Integer }
  Headers = T.type_alias { T::Hash[String, String] }
  Response = T.type_alias { T::Array[String] }

  class Application
    extend T::Sig

    sig { params(env: Rulers::Env).returns([Rulers::StatusCode, Rulers::Headers, Rulers::Response]) }
    def call(env)
      return [404, { "content-type" => "text/html" }, []] if env["PATH_INFO"] == "/favicon.ico"

      klass, action = get_controller_and_action(env)

      if klass.nil?
        return [404, { "content-type" => "text/html" },
                ["There is no controller named \"#{klass.to_s.capitalize}Controller\""]]
      end

      controller = T.unsafe(klass).new(env)

      response = controller._process(action)

      [200, { "content-type" => "text/html" }, [response]]
    end
  end
end
