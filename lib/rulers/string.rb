# typed: strict
# frozen_string_literal: true

class String
  extend T::Sig

  sig { returns(String) }
  def to_underscore
    gsub(/::/, "/")
      .gsub(/([A-Z]+)([A-Z][a-z])/, "\1_\2")
      .gsub(/([a-z\d])([A-Z])/, "\1_\2")
      .tr("-", "_")
      .downcase
  end
end
