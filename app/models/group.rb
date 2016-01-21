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

  def get_cards
    user = User.find_by(id: session[:user_id])
    board_permission = user.permissions.where(board_id: board).first

    if board_permission.to_card_only
      cards.joins(:users).where(user:user)
    else
      cards
    end
  end
end
