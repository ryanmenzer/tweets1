get '/' do
  # Look in app/views/index.erb
  erb :index
end

get '/:username' do
  @user = Twitteruser.find_by_screen_name(params[:username])
  @user ||= Twitteruser.create(screen_name: params[:username])


  if @user.tweets_stale?
    @updated = "Tweets were fetched now..."
    @user.fetch_tweets!
  else
    @updated = "Tweets are cached and are #{Time.now - @user.tweets.last.updated_at} seconds old"
  end

  @tweets = @user.tweets

  erb :tweets
end
