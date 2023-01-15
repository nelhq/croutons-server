Sentry.init do |config|
  config.dsn = 'https://657a74a9ac5c4557856e6d435f7cbae7@o1386866.ingest.sentry.io/4504507678392320'
  config.breadcrumbs_logger = [:active_support_logger, :http_logger]

  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0
  # or
  config.traces_sampler = lambda do |context|
    true
  end
end
