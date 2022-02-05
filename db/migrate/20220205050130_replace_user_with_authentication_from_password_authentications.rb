class ReplaceUserWithAuthenticationFromPasswordAuthentications < ActiveRecord::Migration[6.1]
  def change
    remove_column :password_authentications, :user_id
    add_reference :password_authentications, :authentication, null: false, foreign_key: true
  end
end
