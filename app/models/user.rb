class User < ActiveRecord::Base

  #TODO: REMOVER EL MASS-ASSIGMENT DE ROL + AÑADIR POR DEFAULT EL ROL DE USUARIO
  # O tal vez crear un modelo de roles como sugire Ryan Bates :P
  attr_accessible :birthday, :city_state, :email, :last_name, :name, :newuser, :phone, :provider, :sex, :streetadr, :win_points, :zipcode, :oauth_token, :oauth_expires_at, :provider, :uid, :image, :password, :password_confirmation

  ROLES = %w[admin moderator author banned]
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable #, :confirmable
  has_many :businesses
  has_many :cards
  # Sub level Association
  has_many :eras, :through => :cards

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
      user.birthday = auth.extra.raw_info.birthday
      user.sex = auth.extra.raw_info.gender

      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      #Tomado de http://asciicasts.com/episodes/236-omniauth-part-2
      user.save(:validate => false)
    end
  end
end
