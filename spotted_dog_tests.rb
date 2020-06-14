require File.join(File.dirname(__FILE__), 'spotted_dog')
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

  def test_foo
    items = [Item.new("foo", 0, 0)]
    SpottedDog.new(items).update_quality()
    assert_equal items[0].name, "fixme"
  end

end