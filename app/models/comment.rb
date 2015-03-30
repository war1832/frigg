class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :blog
  validates :body, :presence => true, :length => { :minimum => 2 }     
end
