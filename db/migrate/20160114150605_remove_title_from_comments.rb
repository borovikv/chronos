class RemoveTitleFromComments < ActiveRecord::Migration
  def change
    def up
      remove_column :comments, :title
    end

    def down
      add_column :comments, :title, :string
    end
  end
end
