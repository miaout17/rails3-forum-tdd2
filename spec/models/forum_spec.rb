# == Schema Information
#
# Table name: forums
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#  posts_count :integer         default(0)
#

require File.expand_path("../../spec_helper.rb", __FILE__)

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

  it "updates forum's counter cache" do
    post = Factory(:post)
    forum_id = post.forum_id
    forum = Forum.find(forum_id)

    forum.posts_count.should == 1
    post.destroy

    forum.reload
    forum.posts_count.should == 0
  end

end
