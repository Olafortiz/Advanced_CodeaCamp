class CreateTweets < ActiveRecord::Migration
  
  def change

    create_table :twitter_users do |t|
      t.string :username
    end

    create_table :tweets do |t|
      t.string :body
      t.belongs_to :twitter_user
    end

  end
end
