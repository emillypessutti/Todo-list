class AddNameToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :name, :string
  end
end
