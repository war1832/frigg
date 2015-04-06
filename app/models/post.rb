class Post < ActiveRecord::Base
  has_many :comments
  has_many :ratings
  belongs_to :user
  belongs_to :blog
  
  after_create :send_mail_to_followers
  validates :title, :body, presence: true
  
  def average_rating
    ratings.empty? ? 0 : ratings.sum(:score) / ratings.size
  end

  private 

  def send_mail_to_followers
    self.user.send_user_notifier self
  end
end
