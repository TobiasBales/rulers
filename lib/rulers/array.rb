# typed: strict
# frozen_string_literal: true

class Array
  extend T::Sig

  sig { returns(T::Boolean) }
  def deeply_empty?
    empty? || all? { |it| T.unsafe(it).empty? }
  end
end
