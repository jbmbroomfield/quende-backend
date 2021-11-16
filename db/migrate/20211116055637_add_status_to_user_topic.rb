class AddStatusToUserTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :user_topics, :status, :string
  end
end
