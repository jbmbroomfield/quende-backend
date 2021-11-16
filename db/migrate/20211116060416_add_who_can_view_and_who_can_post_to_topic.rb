class AddWhoCanViewAndWhoCanPostToTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :who_can_view, :string
    add_column :topics, :who_can_post, :string
  end
end
