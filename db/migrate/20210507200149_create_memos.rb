class CreateMemos < ActiveRecord::Migration[5.2]
  def change
    create_table :memos do |t|
      t.string :name
      t.text :description
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :memos, [:user_id, :created_at]
  end
end
