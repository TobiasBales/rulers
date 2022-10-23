# typed: strict
# frozen_string_literal: true

class Object
  extend T::Sig

  @calling_for = T.let(Set.new, T::Set[Symbol])

  sig { params(const: Symbol).returns(T.nilable(Class)) }
  def self.const_missing(const)
    return nil if @calling_for.include?(const)

    @calling_for.add(const)

    require const.to_s.to_underscore
    klass = Object.const_get(const)

    @calling_for.delete(const)

    klass
  end
end
