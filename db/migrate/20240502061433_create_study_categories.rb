class CreateStudyCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :study_categories do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true
      t.boolean :is_archived

      t.timestamps
    end
  end
end
