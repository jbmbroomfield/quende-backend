class CreateSubsections < ActiveRecord::Migration[6.1]
  def change
    create_table :subsections do |t|
      t.references :section, null: false, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
