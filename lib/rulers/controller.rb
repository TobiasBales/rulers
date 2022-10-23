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
