class Blog < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :title, :contents, :user_id, :publish_at, :is_published

  validates :contents, :user_id, :presence => true
  validates :title, :presence => true, :uniqueness => true
  
  has_many  :comments, :dependent => :destroy
  has_many  :fist_bumps, :dependent => :destroy
  belongs_to :user

  paginates_per 10

  scope :published_blogs, where(:is_published => true).order("updated_at DESC").limit(5)

  def blog_like_count
    count = self.fist_bumps.where(:is_like => true).count
    count == 0 ? nil : "+#{count}"
  end
end
