desc "This task is called by the Heroku scheduler add-on"

task :create_movie_log => :environment do
  TiktokMovie.all.find_each(batch_size: 100) do |tiktok_movie|
    p 'start create tiktok movie log'
    tiktok_movie.create_movie_log
    p 'end create tiktok movie log'
    sleep(3)
  end
end


task :tiktok_access_token => :environment do
  TiktokAccessToken.all.find_each(batch_size: 100) do |tiktok_access_token|
    p 'start refresh access token'
    tiktok_access_token.refresh_access_token
    p 'end refresh access token'
    sleep(3)
  end
end
