class Board < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :users
  has_many :groups

  validates :name, :user, presence: true

  def to_s
    name
  end
end
