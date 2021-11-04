class CreateFlags < ActiveRecord::Migration[6.1]
  def change
    create_table :flags do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :category

      t.timestamps
    end
  end
end
