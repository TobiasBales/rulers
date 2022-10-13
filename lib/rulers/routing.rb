# typed: strict
# frozen_string_literal: true

module Rulers
  class Application
    extend T::Sig

    sig { params(env: Rulers::Env).returns([Class, String])}
    def get_controller_and_action(env)
      path = T.cast(env["PATH_INFO"], String)

      _, controller, action, after = path.split('/', 4)

      [Object.const_get("#{controller&.capitalize}Controller"), T.must(action)]
    end
  end
end
