Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], scope: "email,user_location,user_birthday"
  provider :facebook, '498624323525272', '7803da04ad9d8b70b1425c525fc20103', scope: "email,user_location,user_birthday", :display => 'popup'
end