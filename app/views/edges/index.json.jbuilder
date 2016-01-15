json.array!(@edges) do |edge|
  json.extract! edge, :id, :card_a_id, :card_b_id, :relation
  json.url edge_url(edge, format: :json)
end
