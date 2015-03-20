class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts
  has_many :comments
  
  before_save do
    self.name.downcase!
  end
  
  validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/,
                                               message: "invalid name" }
  def to_param
    name
  end
  
  def self.find(input)
    input.to_i == 0 ? find_by_name(input) : super
  end
end
