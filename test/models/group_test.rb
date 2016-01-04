require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  setup do
    @board = boards(:one)
  end

  test 'group should have board' do
    g = Group.new

    assert g.invalid?
    assert g.errors[:board].any?

    g.board = @board
    assert g.valid?
  end
end
