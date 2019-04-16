class CreateRetweets < ActiveRecord::Migration[5.2]
  def change
    create_table :retweets, {id: false} do |t|
      t.string :id, primary_key: true
      t.references :tweet, type: :string
      t.references :user, type: :string

      t.timestamps
    end
  end
end
