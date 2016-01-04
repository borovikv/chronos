class CreateJoinTableBoardUser < ActiveRecord::Migration
  def change
    create_join_table :boards, :users do |t|
      t.index [:board_id, :user_id]
      t.index [:user_id, :board_id]
    end
  end
end
