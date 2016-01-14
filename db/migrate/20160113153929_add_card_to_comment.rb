class AddCardToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :card, index: true, foreign_key: true
  end
end
