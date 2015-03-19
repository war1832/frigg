class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user
  belongs_to :blog
  validates :title, :body, presence: true
end
