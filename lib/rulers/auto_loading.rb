# typed: strict
# frozen_string_literal: true

class Object
  extend T::Sig

  sig { params(const: Symbol).returns(Class) }
  def self.const_missing(const)
    require const.to_s.to_underscore

    Object.const_get(const)
  end
end
