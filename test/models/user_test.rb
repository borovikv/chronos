require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user attributes must not be empty' do
    user = User.new
    assert user.invalid?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end

  test 'user must have correct email' do
    user = User.new(password_digest: BCrypt::Password.create('secret'))

    user.email = 'abc'
    assert user.invalid?
    assert_equal [user.email + ' is incorrect email'], user.errors[:email]

    user.email = 'abc@mail.com'
    assert user.valid?
  end

  test 'user email must be unique' do
    user = User.new(email: 'sam@mail.com', password_digest: BCrypt::Password.create('secret'))
    assert user.invalid?
    assert user.errors[:email].any?
    assert_equal ['has already been taken'], user.errors[:email]
  end
end
