class AddPostCount < ActiveRecord::Migration
  def self.up
    add_column :forums, :posts_count, :integer, :default => 0
    Forum.find(:all).each do |p|
      Forum.update_counters p.id, :posts_count => p.posts.length
    end
  end

  def self.down
    remove_column :forums, :posts_count
  end
end
