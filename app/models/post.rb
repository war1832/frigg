class Post < ActiveRecord::Base
  has_many :comments
  has_many :ratings
  belongs_to :user
  belongs_to :blog
  validates :title, :body, presence: true
  
  def average_rating
    ratings.sum(:score) / ratings.size
  end
end
