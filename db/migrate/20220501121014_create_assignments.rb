class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.belongs_to :classroom, index: true, foreign_key: true
      t.string :name
      t.string :details
      t.timestamps
    end
  end
end
