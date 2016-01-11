class Group < ActiveRecord::Base
  belongs_to :board
  has_many :cards

  validates :board, presence: true

  def to_s
    'group ' + (name || '') + id.to_s
  end
end
