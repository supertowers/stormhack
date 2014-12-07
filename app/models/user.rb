class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  has_many :auditor_participations
  has_many :tester_participations
  has_many :sites # as owner
  has_many :testing_sites, through: :tester_participations, source: :site
  has_many :activities

  SCORE_INCREASED_PER_VULNERABILITY = 20
  SCORE_DECREASED_PER_VULNERABILITY = 5

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.image = auth.info.image
      user.token = auth.credentials.token
      user.expires_at = Time.at(auth.credentials.expires_at)
      user.password = Devise.friendly_token[0,20]
    end
  end

  def self.from_facebook(data, token)
    where(provider: 'facebook', uid: data['id']).first_or_create do |user|
      user.email = data['email']
      user.provider = 'facebook'
      user.uid = data['id']
      user.name = data['name']
      # user.image = auth.info.image
      user.token = token
      user.password = Devise.friendly_token[0,20]
    end
  end

  def increase_score
    user.score = user.score + SCORE_INCREASED_PER_VULNERABILITY

    user.save
  end

  def decrease_score
    user.score = user.score - SCORE_INCREASED_PER_VULNERABILITY
    user.score = 0 if user.score < 0

    user.save
  end

  def to_s
    email
  end
end

