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

  def get_cards(user)
    if board.user == user
      cards
    elsif board.users.include? user
      board_permission = user.permissions.where(board_id: board).distinct.first

      if board_permission && board_permission.to_card_only
        cards.joins(:users).where("cards_users.user_id = #{user.id}").distinct.order(:order)
      else
        cards.order(:order)
      end
    end
  end
end
