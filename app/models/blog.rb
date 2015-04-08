class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :editors, dependent: :destroy

  before_save do
    self.name.downcase!
  end
  
  validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/,
                                               message: "invalid name" }
  def to_param
    name
  end
  
  def self.find(input)
    find_by_name(input)
  end
  
  def self.search(search)
    param =  search.downcase
    where("lower(title) LIKE ? OR lower(second_title) LIKE ? OR lower(name) LIKE ? ", 
                             "%#{ param }%","%#{ param }%", "%#{ param }%") 
  end
  
  def exists?
    Blog.where(id: id).any?
  end
end
