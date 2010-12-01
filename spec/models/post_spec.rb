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

require File.expand_path("../../spec_helper.rb", __FILE__)

describe Post do
  before(:each) do
    @params = {
      :title       => Faker::Lorem.sentence,
      :description => Faker::Lorem.sentence,
      :forum_id    => 4, 
      :user_id     => 7
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

  it "is invalid without user_id" do
    Post.new(@params.except(:user_id)).should_not be_valid
  end

  it "could get its forum" do
    post = Factory(:post)

    forum = post.forum
    forum.should_not be nil

    forum.posts.should include post
  end

  it "should be editable by its author" do
    post = Factory(:post)
    author = post.user
    post.editable_by?(author).should be true
  end

  it "shouldn't be editable by other users" do
    post = Factory(:post)
    other_user = Factory(:user)
    post.editable_by?(other_user).should be false
  end

  it "could get its user" do
    post = Factory(:post)

    user = post.user
    user.should_not be nil

    user.posts.should include post
  end

  describe "could be sorted by named_scope" do
    before(:each) do
      @forum = Factory(:forum)
      @user = Factory(:user)
      @all_posts = []
      now_time = Time.now
      1.upto(9) do |i|
        post_time = now_time + i.minutes
        post = Factory(:post, :forum => @forum, :user => @user, :created_at => post_time)
        @all_posts << post
      end
    end

    it "#sort_by_date" do
      posts = @forum.posts.sort_by_date
      posts.should eq(@all_posts.reverse)
    end
        
    it "#sort_by_date_rev" do
      posts = @forum.posts.sort_by_date_rev
      posts.should eq(@all_posts)
    end
  end

end
