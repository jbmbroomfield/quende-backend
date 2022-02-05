class CreateEmails < ActiveRecord::Migration[6.1]
  def change
    create_table :emails do |t|
      t.references :user, null: false, foreign_key: true
      t.string :address, null: false
      t.boolean :confirmed, default: false

      t.timestamps
    end
  end
end
