class CreateEdges < ActiveRecord::Migration
  def change
    create_table :edges do |t|
      t.integer :card_a_id, null: false
      t.integer :card_b_id, null: false
      t.integer :relation

      t.timestamps null: false
    end
  end
end
