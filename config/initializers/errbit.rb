if Rails.env.production?
  Airbrake.configure do |config|
    config.project_id  = ENV['AIRBRAKE_PROJECT_ID']
    config.project_key = ENV['AIRBRAKE_PROJECT_KEY']
    config.host        = ENV['AIRBRAKE_HOST']
  end
else
  Airbrake.configure do |config|
    config.environment = Rails.env
    config.ignore_environments = %w(development test)
    config.project_id = '1'
  end
end
