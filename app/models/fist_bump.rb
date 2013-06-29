class FistBump < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :is_like, :user_id, :blog_id
  belongs_to :user
  belongs_to :blog
end
