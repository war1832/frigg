class User < ActiveRecord::Base
  require 'digest/md5'

  has_many :blogs, dependent: :destroy
  has_many :posts, through: :blogs
  has_many :comments, through: :posts
  has_many :ratings, dependent: :destroy
  has_many :editors, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  attr_accessor :login
  devise :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :omniauth_providers => [:facebook],
         :authentication_keys => [:login]

  validates :username,
    :presence => true,
    :uniqueness => {
    :case_sensitive => false
  }

  scope :admins, -> { where(admin: true) }

  def self.from_omniauth(auth)
  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.username = auth.info.name.downcase.delete(' ')
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.is_female = auth.extra.raw_info.gender == "male" ? false : true
      user.skip_confirmation!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def send_user_notifier post
    begin
      UserNotifier.new_post(post).deliver_later
    rescue Exception => e
      puts e.message
      puts e.backtrace.inspect
    end
  end

  def gravatar_url size
    hash = Digest::MD5.hexdigest(email.downcase)
    "http://www.gravatar.com/avatar/#{hash}?s=#{size}&r=pg&d=mm"
  end

  def follow user
    active_relationships.create(followed_id: user.id)
  end

  def stop_following user
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    following.include?(user)
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def can_manager? blog
    admin? || blog.user == self || ( self && blog.editors.exists?(user: self))
  end

  def can_remove_comment? comment
    can_manager?(comment.post.blog) || ( self && comment.user == self )
  end

  def facebook_user?
    self.provider == "facebook"
  end

  def to_param
    username
  end

  def self.find(input)
    find_by_username(input)
  end

  def post_count
    posts.count
  end

  def comment_count
   comments.count
  end
end
