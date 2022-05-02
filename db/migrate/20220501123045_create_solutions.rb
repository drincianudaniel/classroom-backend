class CreateSolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :solutions do |t|
      t.belongs_to :assignment, index: true, foreign_key: true
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.integer :grade
      t.string :solution_content
      t.timestamps
    end
  end
end
