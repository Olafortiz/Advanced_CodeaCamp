class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets
  validates :username, uniqueness: true
end
