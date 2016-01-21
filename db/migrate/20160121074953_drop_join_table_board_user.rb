class DropJoinTableBoardUser < ActiveRecord::Migration
  def change
    drop_join_table :boards, :users
  end
end
