class UserTopicSubscribedDefaultToTrue < ActiveRecord::Migration[6.1]
  def change
    change_column :user_topics, :subscribed, :boolean, default: false
  end
end
