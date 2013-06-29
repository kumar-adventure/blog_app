class PublishColumnToBlog < ActiveRecord::Migration
  def change
    add_column :blogs, :publish_at, :datetime
    add_column :blogs, :is_published, :boolean, :default => false
  end
end
