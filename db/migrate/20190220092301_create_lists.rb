class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :name, null: false
      t.boolean :publish, null: false, default: true

      t.timestamps
    end
  end
end
