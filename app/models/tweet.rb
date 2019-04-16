class Tweet < ApplicationRecord
  belongs_to :parent, class_name: 'Tweet', foreign_key: :tweet_id, required: false
  has_many :replies, class_name: 'Tweet', foreign_key: :tweet_id, dependent: :destroy
  belongs_to :user
end
