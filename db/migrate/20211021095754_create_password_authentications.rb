class CreatePasswordAuthentications < ActiveRecord::Migration[6.1]
  def change
    create_table :password_authentications do |t|
      t.references :user, null: false, foreign_key: true
      t.string :password_digest

      t.timestamps
    end
  end
end
