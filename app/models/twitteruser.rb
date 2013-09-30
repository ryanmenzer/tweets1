class Twitteruser < ActiveRecord::Base
  has_many :tweets

  def fetch_tweets!
    tweets = Twitter.user_timeline(self.screen_name)
    self.tweets.delete_all
    tweets.each do |tweet|
      newtweet = Tweet.create(text: tweet.text)
      self.tweets << newtweet
    end
    self.tweets
  end  

  def tweets_stale?
    return true if self.tweets.empty?
    Time.now - self.tweets.last.updated_at > 900
  end

end
