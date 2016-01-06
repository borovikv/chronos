class Card < ActiveRecord::Base
  belongs_to :group

  def to_s
    title
  end
end
