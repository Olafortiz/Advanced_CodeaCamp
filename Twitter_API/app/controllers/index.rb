get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  erb :index
end

post '/user' do
  user_name = params[:username]
  redirect to "/#{user_name}"
end

get '/:username' do 
  @user_name = params[:username]
  new_user = TwitterUser.new(username: @user_name)
  @tweets = CLIENT.user_timeline(@user_name)
  if new_user.save
    new_user.tweets << @tweets

  end

  erb :show_tweets

end