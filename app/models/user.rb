class User < ActiveRecord::Base
  has_many :blogs
  has_many :ratings
  attr_accessor :login

  include Gravtastic
  gravtastic

  acts_as_followable
  acts_as_follower

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable,
         :authentication_keys => [:login]

  validates :username,
    :presence => true,
    :uniqueness => {
    :case_sensitive => false
  }

  def send_user_notifier post
    UserNotifier.new_post(post).deliver_later
  end

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
  
  def to_param
    username
  end
  
  def self.find(input)
    find_by_username(input)
  end
  
  def post_count
   Post.where(:user_id => id).count.to_s
  end
  
  def comment_count
   Comment.where(:user_id => id).count.to_s
  end
end
