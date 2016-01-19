class Edge < ActiveRecord::Base
  belongs_to :card_a, class_name: 'Card', foreign_key: :card_a_id
  belongs_to :card_b, class_name: 'Card', foreign_key: :card_b_id

  validates :card_a_id, :card_b_id, :relation, presence: true, on: :create
  validate :has_cards, on: :create
  validate :only_one_parent, on: :create
  validates_uniqueness_of :card_a_id, scope: [:card_b_id, :relation]

  def get_related_to(card)
    if card == card_a
      card_b
    elsif card == card_b
      card_a
    end
  end

  private

    def has_cards
      errors.add(:card_a_id, "card doesn't exist") unless Card.exists? card_a_id
      errors.add(:card_b_id, "card doesn't exist") unless Card.exists? card_b_id
    end

    def only_one_parent
      if relation == EdgesController.helpers.parent
        if Edge.exists?(card_b_id: card_b_id, relation: relation)
          errors.add(:card_b_id, "card #{card_b} already have parent")
        end

        if Edge.exists?(card_a_id: card_b_id, card_b_id: card_a_id, relation: relation)
          errors.add(:card_a_id, " [#{card_a}] can't have as child self parent [#{card_b}]")
        end

        if card_a_id == card_b_id
          errors.add(:card_a_id, 'card can be self parent')
          errors.add(:card_b_id, 'card can be self parent')
        end
      end

    end

end
