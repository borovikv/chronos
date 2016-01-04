class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.text :text
      t.text :html
      t.belongs_to :group, index: true, foreign_key: true
      t.datetime :due_date
      t.datetime :start_date

      t.timestamps null: false
    end
  end
end
