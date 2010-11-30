# == Schema Information
#
# Table name: forums
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Forum do
  before(:each) do
    @params = {:title => Faker::Lorem.sentence}
  end

  it "is valid with params" do
    Forum.new(@params).should be_valid
  end

  it "is invalid without title" do
    Forum.new(@params.except(:title)).should_not be_valid
  end

  it "could get its posts" do
    forum = Factory(:forum)
    post = Factory.build(:post, :forum => forum)
    post.save
    forum.reload
    forum.posts.count.should == 1
    forum.posts.should include(post)
  end

  describe "is destroyed" do
    it "also delete its posts" do
      forum = Factory(:forum)
      post = Factory(:post, :forum => forum)
      post_id = post.id
      Post.find_by_id(post_id).should == post

      forum.destroy

      Post.find_by_id(post_id).should == nil
    end
  end

end
