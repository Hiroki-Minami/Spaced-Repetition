class CreateStudyCards < ActiveRecord::Migration[7.1]
  def change
    create_table :study_cards do |t|
      t.belongs_to :card, null: false, foreign_key: true
      t.belongs_to :study_category, null: false, foreign_key: true
      t.float :understanding_level
      t.boolean :is_archived

      t.timestamps
    end
  end
end
