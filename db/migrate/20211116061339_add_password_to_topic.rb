class AddPasswordToTopic < ActiveRecord::Migration[6.1]
  def change
    add_column :topics, :password, :string
  end
end
