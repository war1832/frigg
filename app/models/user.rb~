class User < ActiveRecord::Base
  has_many :blogs
  has_many :ratings
  attr_accessor :login

  include Gravtastic
  gravtastic

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :authentication_keys => [:login]

  validates :username,
    :presence => true,
    :uniqueness => {
    :case_sensitive => false
  }

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value =>     login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end
  
  def self.find(input)
    input.to_i == 0 ? find_by_username(input) : super
  end
  
  def post_count
   Post.count(:id => id).to_s
  end
  
  def comment_count
   Comment.count(:id => id).to_s
  end
  
end
