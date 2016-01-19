class Card < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  has_many :a_edges, class_name: 'Edge', foreign_key: :card_a_id
  has_many :b_edges, class_name: 'Edge', foreign_key: :card_b_id

  def to_s
    title
  end

  def parent
    Card.joins(:a_edges).where("edges.card_b_id = #{id} and edges.relation = #{ EdgesController.helpers.parent } and cards.id != #{id}").first
  end

  def related_cards
    unless @related
      @related = edges_to_hash(a_edges)
      undirected_from_b_side = edges_to_hash(b_edges.where("edges.relation = #{ EdgesController.helpers.undirected }"))
      @related['undirected'] = @related['undirected'] || []
      @related['undirected'] += (undirected_from_b_side['undirected']) || []
    end
    @related
  end

  def edges_to_hash(edges)
    related = {}
    relations = %w(undirected children directed)
    edges.each do |edge|
      relation = relations[edge.relation]
      unless related.has_key? relation
        related[relation] = []
      end
      related[relation].append([edge.get_related_to(self), edge])
    end
    related

  end


  def children
    Card.joins(:a_edges).where("edges.relation = #{ EdgesController.helpers.parent }")
  end

  def count_relatives
    counter = 0
    related_cards.each do |type, relatives|
      counter += relatives.length
    end
    counter
  end

end
