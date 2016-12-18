class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :url, null: false
    end
    add_index :links, :url, unique: true
  end
end
