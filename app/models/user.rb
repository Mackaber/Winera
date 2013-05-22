class User < ActiveRecord::Base
  attr_accessible :birthdate_date, :city_state, :email, :last_name, :name, :newuser, :phone, :provider, :sex, :streetadr, :win_points, :zipcode, :oauth_token, :oauth_expires_at, :provider, :uid, :image, :password, :password_confirmation

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable

  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid

      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)

      user.email = auth.info.email
      user.name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.image = auth.info.image
      #---------------------------------------
      user.city_state = auth.extra.raw_info.location.name
      user.birthdate_date = auth.extra.raw_info.birthday
      user.sex = auth.extra.raw_info.gender



      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save!
    end
  end
end
