class CreateTweets < ActiveRecord::Migration
  
  def change

    create_table :twitter_users do |t|
      t.string :username
      t.string :oauth_token
      t.string :oauth_token_secret
      t.timestamps
    end

    create_table :tweets do |t|
      t.string :body
      t.belongs_to :twitter_user
      t.timestamps
    end

  end
end
