# typed: strict
# frozen_string_literal: true

class Object
  extend T::Sig

  sig { params(const: Symbol).returns(T.nilable(Class)) }
  def self.const_missing(const)
    return nil if @calling_const_missing

    @calling_const_missing = T.let(true, T.nilable(T::Boolean))

    require const.to_s.to_underscore
    klass = Object.const_get(const)

    @calling_const_missing = false

    klass
  end
end
