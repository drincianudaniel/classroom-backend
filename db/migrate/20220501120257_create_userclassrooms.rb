class CreateUserclassrooms < ActiveRecord::Migration[7.0]
  def change
    create_table :userclassrooms, id: false do |t|
      t.belongs_to :user
      t.belongs_to :classroom
      t.timestamps
    end
  end
end