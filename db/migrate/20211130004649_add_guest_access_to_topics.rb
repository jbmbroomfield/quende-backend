class AddGuestAccessToTopics < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :guest_access, :string
  end
end
