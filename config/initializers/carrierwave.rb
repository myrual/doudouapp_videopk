CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :upyun
    config.upyun_username = ENV["UPYUN_OPERATOR_ID"]
    config.upyun_password = ENV["UPYUN_OPERATOR_PASSWORD"]
    config.upyun_bucket = ENV["UPYUN_BUCKET"]
  # upyun_bucket_domain 以后将会弃用，请改用 upyun_bucket_host
  # config.upyun_bucket_domain = "my_bucket.files.example.com"
    config.upyun_bucket_host = ENV["UPYUN_HOST"]
  else
    config.storage :file
  end
end
