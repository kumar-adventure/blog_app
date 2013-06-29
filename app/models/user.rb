class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,
                  :username, :first_name, :last_name, :login, :confirmed_at,
                  :confirmation_token, :confirmation_sent_at, 
                  :unconfirmed_email, :avatar, :avatar_cache
  
  attr_accessor :login, :avatar_cache
  # attr_accessible :title, :body
  validates :first_name, :last_name, :presence => true, :format => { :with => /^[\.a-zA-Z ]+$/, :message => "Only letters allowed"  }
  validates :username, :presence => true, :uniqueness => true
  has_many  :comments
  has_many  :blogs, :dependent => :destroy
  has_many  :fist_bumps

  mount_uploader :avatar, AvatarUploader

  paginates_per 10

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def self.user_serach_by_keyword(keyword)
    result = []
    keyword.split(" ").each do |word|
      result << where(
        "lower(username) like ? "+
        "or "+
        "lower(first_name) like ? "+
        "or "+
        "lower(last_name) like ?",
        '%'+ word.downcase+'%',
        '%'+word.downcase+'%',
        '%'+word.downcase+'%'
      )
    end
    return result.flatten
  end

  def full_name
    "#{first_name}" + " " + "#{last_name}"
  end

end
