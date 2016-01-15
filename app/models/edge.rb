class Edge < ActiveRecord::Base
  belongs_to :card_a, class_name: 'Card', foreign_key: :card_a_id
  belongs_to :card_b, class_name: 'Card', foreign_key: :card_b_id

end
