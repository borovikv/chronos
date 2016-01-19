class User < ActiveRecord::Base
  has_many :boards
  has_and_belongs_to_many :available_boards, class_name: 'Board'

  validates :email, presence: true, uniqueness:true
  validates :email, format:{
      with: %r{[^@]+@[^@]+\.[^@]{2,3}},
      message: "%{value} is incorrect email"
  }
  has_secure_password

  def to_s
    email
  end
end
