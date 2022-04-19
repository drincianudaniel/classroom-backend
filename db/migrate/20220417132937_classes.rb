class Classes < ActiveRecord::Migration[7.0]
  def change
    create_table :classes do |t|
      t.string :name
      t.string :details
      t.timestamps
    end
  end
end
