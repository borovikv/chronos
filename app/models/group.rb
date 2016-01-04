class Group < ActiveRecord::Base
  belongs_to :board

  validates :board, presence: true
end
