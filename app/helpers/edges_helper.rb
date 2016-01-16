module EdgesHelper
  def undirected
    0
  end
  def parent
    1
  end
  def directed
    2
  end

  def edge_relation_str(relation)
    %w(undirected parent directed)[relation]
  end

end
