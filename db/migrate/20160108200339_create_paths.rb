class CreatePaths < ActiveRecord::Migration
  def change
    create_table :paths do |t|
      t.string :name
      t.integer :next_chapter_id
      t.references :chapter, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
