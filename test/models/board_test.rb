require 'test_helper'

class BoardTest < ActiveSupport::TestCase
  test 'board attributes must not be empty' do
    b = Board.new
    assert b.invalid?
    assert b.errors['user'].any?
    assert b.errors['name'].any?
  end
end
