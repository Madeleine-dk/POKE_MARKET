class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :title
      t.string :description
      t.integer :ppd
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
