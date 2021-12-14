class AddCanViewAndCanPostToUserTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :user_topics, :can_view, :boolean
    add_column :user_topics, :can_post, :boolean
  end
end
