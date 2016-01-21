class Board < ActiveRecord::Base
  belongs_to :user
  has_many :permissions
  has_many :users, through: :permissions
  has_many :groups

  validates :name, :user, presence: true

  def to_s
    name
  end

  def user_have_permission_to_view(u)
    user == u || users.include?(u)
  end

end
