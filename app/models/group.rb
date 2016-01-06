class Group < ActiveRecord::Base
  belongs_to :board

  validates :board, presence: true

  def to_s
    'group ' + (name || '') + id.to_s
  end
end
