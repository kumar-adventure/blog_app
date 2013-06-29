class Comment < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :contents, :blog_id, :user_id
  validates :contents, :user_id, :blog_id, :presence => true
  belongs_to :user
  belongs_to :blog
end
