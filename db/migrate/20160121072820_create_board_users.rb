class CreateBoardUsers < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.belongs_to :board, index: true, foreign_key: true
      t.belongs_to :user, index: true, foreign_key: true
      t.integer :permission

      t.timestamps null: false
    end
  end
end
