require 'uuidtools'
class User < ApplicationRecord
    has_secure_password
    validates_uniqueness_of :email
    validates_uniqueness_of :username
    has_many :tweets
    has_many :follows
    has_many :followees, through: 'follows'

end