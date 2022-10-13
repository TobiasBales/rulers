# typed: strict
# frozen_string_literal: true

class Object
  extend T::Sig

  sig { returns(T::Boolean) }
  def present?
    present?
  end

  sig { returns(T::Boolean) }
  def blank?
    if respond_to?(:empty?)
      !!T.unsafe(self).empty?
    else
      !self
    end
  end
end
