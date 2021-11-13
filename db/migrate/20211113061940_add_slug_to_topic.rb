class AddSlugToTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :slug, :string
  end
end
