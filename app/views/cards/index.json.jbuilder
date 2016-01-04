json.array!(@cards) do |card|
  json.extract! card, :id, :title, :text, :html, :group_id, :due_date, :start_date
  json.url card_url(card, format: :json)
end
