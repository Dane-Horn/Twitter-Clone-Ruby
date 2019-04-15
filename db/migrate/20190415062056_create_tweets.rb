class CreateTweets < ActiveRecord::Migration[5.2]
  def change
    create_table :tweets, {id: false} do |t|
      t.string :id, primary_key: true
      t.references :user, type: :string, null: false
      t.references :tweet, type: :string, default: nil, null: true
      t.string :text
      t.integer :likes, default: 0
      t.timestamps
    end
  end
end
