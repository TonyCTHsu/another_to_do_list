class CreateListItems < ActiveRecord::Migration[5.2]
  def change
    create_table :list_items do |t|
      t.text :description, null: false
      t.boolean :publish, null: false, default: true
      t.references :list

      t.timestamps
    end
  end
end
