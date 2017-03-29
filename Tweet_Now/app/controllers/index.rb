get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end



post '/user' do
  
@user_name = params[:username]
  @user = TwitterUser.find_or_create_by(username: @user_name)
  # Se crea un TwitterUser si no existe en la base de datos de lo contrario trae de la base al usuario.

  tweets = Tweet.where(twitter_user_id: @user.id)
  # cosa = tweets[0].id
  # puts "este es el id: #{cosa}"
  if tweets.empty?
    tweets = CLIENT.user_timeline(@user_name)
    tweets.each do  |t|

      Tweet.create(twitter_user_id: @user.id, body: t.text)
    end
   # La base de datos no tiene tweets?
   # Pide a Twitter los últimos tweets del usuario y los guarda en la base de datos
  end

  if Time.now - tweets.first.created_at > 2000
    puts "estamos pidiento tweets"
    tweets = CLIENT.user_timeline(username: @user.username)
    tweets.each do  |t|
      Tweet.create(twitter_user_id: @user.id, body: t.text)
    end

    # Pide a Twitter los últimos tweets del usuario y los guarda en la base de datos
  end

  @tweets = Tweet.where(twitter_user_id: @user.id).first(10)
  # Se hace una petición por los ultimos 10 tweets a la base de datos. 
  if request.xhr?
    erb :show_tweets, layout: false
  end
end

post '/tweet' do
  @message = nil
  # Recibe el input del usuario
  tweet = params[:tweet]
  new_tweet = Tweet.new(body: tweet)
  find_tweet = Tweet.find_by(body: tweet)
  
  if find_tweet
    "el tweet ya se envio antes"
  elsif new_tweet.save
    "el tweet se envio con exito"
  end
end
