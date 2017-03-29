get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end

get '/sign_in' do
  # El método `request_token` es uno de los helpers
  # Esto lleva al usuario a una página de twitter donde sera atentificado con sus credenciales
  redirect request_token.authorize_url(:oauth_callback => "http://#{host_and_port}/auth")
  # Cuando el usuario otorga sus credenciales es redirigido a la callback_url 
  # Dentro de params twitter regresa un 'request_token' llamado 'oauth_verifier'
end

get '/auth' do
  puts "HOLAA"
  # Volvemos a mandar a twitter el 'request_token' a cambio de un 'access_token' 
  # Este 'access_token' lo utilizaremos para futuras comunicaciones.   
  @access_token = request_token.get_access_token(:oauth_verifier => params[:oauth_verifier])
  
  username = @access_token.params['screen_name']
  puts "*" * 50
  puts username
  session[:oauth_token] = @access_token.params['oauth_token']
  session[:oauth_token_secret] = @access_token.params['oauth_token_secret']
  # Despues de utilizar el 'request token' ya podemos borrarlo, porque no vuelve a servir. 
  session.delete(:request_token)
  # Aquí es donde deberás crear la cuenta del usuario y guardar usando el 'access_token' lo siguiente:
  # nombre, oauth_token y oauth_token_secret
  # No olvides crear su sesión 

  TwitterUser.create(username: username, oauth_token: session[:oauth_token], oauth_token_secret: session[:oauth_token_secret])

  # username =  session[:username]
  puts "*" * 100
  puts username
  redirect to("/#{username}")
end



  # Para el signout no olvides borrar el hash de session

get '/:username' do
  @username = params[:username]
  user = TwitterUser.find_by(username: @username)
  # Se crea un TwitterUser si no existe en la base de datos de lo contrario trae de la base al usuario.

  tweets = Tweet.where(twitter_user_id: user.id)
  # cosa = tweets[0].id
  # puts "este es el id: #{cosa}"
  if tweets.empty?
    tweets = CLIENT.user_timeline(@username)
    tweets.each do  |t|

      Tweet.create(twitter_user_id: user.id, body: t.text)
    end
   # La base de datos no tiene tweets?
   # Pide a Twitter los últimos tweets del usuario y los guarda en la base de datos
  end

  if Time.now - tweets.first.created_at > 2000
    puts "estamos pidiento tweets"
    tweets = CLIENT.user_timeline(user.username)
    tweets.each do  |t|
      Tweet.create(twitter_user_id: user.id, body: t.text)
    end

    # Pide a Twitter los últimos tweets del usuario y los guarda en la base de datos
  end

  @tweets = Tweet.where(twitter_user_id: user.id).first(10)
  # Se hace una petición por los ultimos 10 tweets a la base de datos. 

  erb :homepage

end

post '/tweet' do

   cliente_user = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['TWITTER_KEY']
    config.consumer_secret     = ENV["TWITTER_SECRET"]
    config.access_token        = session[:oauth_token]
    config.access_token_secret = session[:oauth_token_secret]
  end

  @message = nil
  # Recibe el input del usuario
  tweet = params[:tweet]
  cliente_user.update(tweet)
  new_tweet = Tweet.new(body: tweet)
  find_tweet = Tweet.find_by(body: tweet)

  if find_tweet
    "el tweet ya se envio antes"
  elsif new_tweet.save
    "el tweet se envio con exito"
  end
end


post '/user/search' do 
@user_name = params[:username]
puts @user_name
@current_user = params[:user]
puts @current_user
redirect to "/#{@current_user}/search/#{@user_name}"

end


get '/:user/search/:username' do 
  @user_name = params[:username]
  puts "+" * 100
  puts @current_user = params[:user]
  @user_tweets = CLIENT.user_timeline(@user_name)

  erb :user_timeline

end

post '/log_out' do 
  session.delete(:oauth_token)
  session.delete(:oauth_token_secret)
  session.delete(:username)

  erb :index
end
