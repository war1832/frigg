class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :comments
  
  before_save do
    self.name.downcase!
  end
  
  validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/,
                                               message: "invalid name" }
end
