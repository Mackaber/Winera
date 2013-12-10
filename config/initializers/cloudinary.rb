Cloudinary.config do |config|
  config.cloud_name = 'winera'
  config.api_key = ENV['cloudinary_key']
  config.api_secret = ENV['cloudinary_secret']
  config.cdn_subdomain = true
end