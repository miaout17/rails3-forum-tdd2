# == Schema Information
#
# Table name: posts
#
#  id          :integer(4)      not null, primary key
#  title       :string(255)
#  description :text
#  forum_id    :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  user_id     :integer(4)
#
# Indexes
#
#  index_posts_on_user_id   (user_id)
#  index_posts_on_forum_id  (forum_id)
#

class Post < ActiveRecord::Base

  belongs_to :forum, :counter_cache => true
  belongs_to :user

  validates_presence_of :title, :description, :forum_id, :user_id

  scope :sort_by_date, :order => "id DESC" 
  scope :sort_by_date_rev, :order => "id ASC" 

  has_attached_file :image

  has_attached_file :image

  def editable_by?(user)
    self.user == user
  end

end
