class User < ActiveRecord::Base
  include Clearance::User

  validates_presence_of :first_name
  validates_presence_of :last_name, unless: :signup_with_facebook?
  validates_presence_of :email
  validates_presence_of :password, unless: :signup_with_facebook?

  validates_uniqueness_of :email
  validates_confirmation_of :password

  has_many :authentications, dependent: :destroy

  def self.create_with_auth_and_hash(authentication,auth_hash)
    create! do |u|
      u.first_name = auth_hash["info"]["name"]
      u.email = auth_hash["extra"]["raw_info"]["email"]

      u.authentications<<(authentication)
    end
  end

  def signup_with_facebook?
    self.authentications.any?
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  def password_optional?
    true
  end

end
