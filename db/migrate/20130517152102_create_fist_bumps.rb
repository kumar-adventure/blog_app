class CreateFistBumps < ActiveRecord::Migration
  def change
    create_table :fist_bumps do |t|
      t.integer :user_id
      t.integer :blog_id
      t.boolean :is_like, :default => false
      t.timestamps
    end
  end
end
