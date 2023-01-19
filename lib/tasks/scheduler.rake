desc "This task is called by the Heroku scheduler add-on"

task :create_movie_log => :environment do
  TiktokMovie.posted_between_hours(60).find_each(batch_size: 100) do |tiktok_movie|
    begin
      p 'start create tiktok movie log'
      tiktok_movie.create_movie_log
      p 'end create tiktok movie log'
    rescue => e
      Sentry.capture_exception(e)
    end
    sleep(3)
  end
end

task :create_reward => :environment do
  begin
    p 'start create reward'
    Reward.calculate_by_tiktok_movies(TiktokMovie.posted_between_minutes(10))
    p 'end create reward'
  rescue => e
    Sentry.capture_exception(e)
  end
end


task :refresh_access_token => :environment do
  TiktokAccessToken.all.find_each(batch_size: 100) do |tiktok_access_token|
    begin
      p 'start refresh access token'
      tiktok_access_token.refresh_access_token
      p 'end refresh access token'
    rescue => e
      Sentry.capture_exception(e)
    end
    sleep(3)
  end
end
