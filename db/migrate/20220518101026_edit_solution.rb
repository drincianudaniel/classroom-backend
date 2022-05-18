class EditSolution < ActiveRecord::Migration[7.0]
  def change
    change_table :solutions do |t|
      t.remove_references :user
    end
  end
end
