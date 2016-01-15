class Card < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  has_many :a_edges, class_name: 'Edge', foreign_key: :card_a_id
  has_many :b_edges, class_name: 'Edge', foreign_key: :card_b_id

  def to_s
    title
  end

  def parent
    begin
      edge = Edge.where(card_b_id: id, relation: EdgesController.helpers.parent).first
      edge.card_a
    rescue
      nil
    end

  end

  def children
    Card.joins(:a_edges).where("edges.card_a_id = #{id} and edges.relation = #{ EdgesController.helpers.parent }")
  end

  def related_cards
    Card.joins(:a_edges).joins(:b_edges)
        .where("(edges.card_a_id = #{id} or edges.card_b_id = #{id}) " +
                   "and edges.relation != #{ EdgesController.helpers.parent } " +
                   "and cards.id != #{id}"
        ).distinct
  end

  def directed_relation_cards
    Card.joins(:a_edges).joins(:b_edges)
        .where("(edges.card_a_id = #{id} or edges.card_b_id = #{id}) " +
                   "and edges.relation == #{ EdgesController.helpers.directed } " +
                   "and cards.id != #{id}"
        ).distinct
  end

  def undirected_relation_cards
    Card.joins(:a_edges).joins(:b_edges)
        .where("(edges.card_a_id = #{id} or edges.card_b_id = #{id}) " +
                   "and edges.relation == #{ EdgesController.helpers.undirected } " +
                   "and cards.id != #{id}"
        ).distinct
  end

end
