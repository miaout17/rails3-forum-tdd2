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
#
# Indexes
#
#  index_posts_on_forum_id  (forum_id)
#

class Post < ActiveRecord::Base
  belongs_to :forum

  validates_presence_of :title, :description, :forum_id
end
