# typed: strict
# frozen_string_literal: true

module Rulers
  class Application
    extend T::Sig

    sig { params(env: Rulers::Env).returns([T.nilable(Class), String]) }
    def get_controller_and_action(env)
      path = T.cast(env["PATH_INFO"], String)

      _, controller, action, _after = path.split("/", 4)

      # rubocop:disable Sorbet/ConstantsFromStrings
      [Object.const_get("#{controller&.capitalize}Controller"), T.must(action)]
      # rubocop:enable Sorbet/ConstantsFromStrings
    end
  end
end
