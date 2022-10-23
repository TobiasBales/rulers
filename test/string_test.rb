# typed: true
# frozen_string_literal: true

require "test_Helper"

class StringTest < Minitest::Test
  def test_to_underscore
    assert_equal "foo_bar", "FooBar".to_underscore
  end
end
