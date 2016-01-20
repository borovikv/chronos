class Group < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board, presence: true

  def to_s
    (name || 'group ') + id.to_s
  end

  def user_have_permission_to_view(user)
    board.user_have_permission_to_view(user)
  end
end
