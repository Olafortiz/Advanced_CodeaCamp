class Tweet < ActiveRecord::Base
  # Remember to create a migration!
  validates :body, uniqueness: true
  belongs_to :twitter_user
end
