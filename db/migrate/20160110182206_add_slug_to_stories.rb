class AddSlugToStories < ActiveRecord::Migration
  def change
    add_column :stories, :slug, :string, index: true
  end
end
