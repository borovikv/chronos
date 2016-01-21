class Card < ActiveRecord::Base
  belongs_to :group
  has_many :comments
  has_many :a_edges, class_name: 'Edge', foreign_key: :card_a_id
  has_many :b_edges, class_name: 'Edge', foreign_key: :card_b_id
  has_and_belongs_to_many :users

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

  def user_have_permission_to_view(user)
    group.board.user_have_permission_to_view user
  end

  def user_can_manage(current_user)
    group.board.user_can_manage(current_user) || users.include?(current_user)
  end




  def self.search(search, user)
    if search
      own_cards = joins(:group => :board).where("text LIKE '%#{search}%' and boards.user_id = #{user.id}").pluck(:id)
      shered_cards = joins(:group => [:board, {board: :users}]).where("text LIKE '%#{search}%' and #{user.id} or users.id = #{user.id}").pluck(:id)

      Card.where(id: own_cards | shered_cards).order(:title)
    else
      find(:all).joins(:group => :board).where("boards.user_id = #{user.id}").order_by(:title)
    end
  end



end
