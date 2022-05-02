class CreateUserassignments < ActiveRecord::Migration[7.0]
  def change
    create_table :userassignments, id: false do |t|
      t.belongs_to :user
      t.belongs_to :assignment
      t.timestamps
    end
  end
end
