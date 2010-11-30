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

require 'spec_helper'

describe Post do
  before(:each) do
    @params = {
      :title       => Faker::Lorem.sentence,
      :description => Faker::Lorem.sentence,
      :forum_id    => 4
    }
  end

  it "is valid with params" do
    Post.new(@params).should be_valid
  end

  it "is invalid without title" do
    Post.new(@params.except(:title)).should_not be_valid
  end

  it "is invalid without description" do
    Post.new(@params.except(:description)).should_not be_valid
  end

  it "is invalid without forum_id" do
    Post.new(@params.except(:forum_id)).should_not be_valid
  end

  it "could get its forum" do
    post = Factory(:post)

    forum = post.forum
    forum.should_not be nil

    forum.posts.should include post
  end

end
