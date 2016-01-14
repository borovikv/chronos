class Card < ActiveRecord::Base
  belongs_to :group
  has_many :comments

  def to_s
    title
  end
end
