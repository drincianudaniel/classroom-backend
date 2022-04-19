class DropClass < ActiveRecord::Migration[7.0]
  def change
    drop_table :classes
  end
end
