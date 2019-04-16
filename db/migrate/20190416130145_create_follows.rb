class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      t.references :user, index: true, foreign_key: true, type: :string
      t.references :followee, index:true, type: :string
      t.timestamps
    end
    add_foreign_key :follows, :users, column: :followee_id
    add_index :follows, [:user_id, :followee_id], unique: true
  end
end
