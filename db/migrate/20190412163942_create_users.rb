class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users, {id: false} do |t|
      t.string :id, primary_key: true
      t.string :username, null: false
      t.string :email, unique: true, null: false
      t.string :password_digest
      t.timestamps
    end
  end
end
