class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(user_data)
    where(provider: user_data.provider, uid: user_data.uid).first_or_create do |user|
      user.email = user_data.info.email
      user.password = Devise.friendly_token[0, 20]
      # user.name = user_data.info.name
      # user.image = user_data.info.image
    end
  end
end
