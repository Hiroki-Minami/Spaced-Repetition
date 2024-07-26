class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.belongs_to :category, null: false, foreign_key: true
      t.text :instruction
      t.text :answer
      t.text :description
      t.string :image

      t.timestamps
    end
  end
end
