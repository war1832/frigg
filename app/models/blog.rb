class Blog < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts, dependent: :destroy
  has_many :editors, dependent: :destroy

  before_save do
    self.name.downcase!
  end

  validates :name, uniqueness: true, format: { with: /\A[a-zA-Z0-9]+\z/,
                                               message: "Invalid name." }
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
    Blog.exists?(id: id)
  end
end
