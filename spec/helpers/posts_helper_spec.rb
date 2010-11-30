require File.expand_path("../../spec_helper.rb", __FILE__)

describe PostsHelper do
  describe "menu" do
    before :each do
      @forum = mock_model(Forum)
      assigns[:forum] = @forum
    end

    describe "#new_post_menu" do
      it "display the new_post menu" do
        menu = helper.new_post_menu

        menu.should =~ /#{forum_posts_path(@forum)}/
      end
    end

    describe "#post_menu" do

      before(:each) do
        @forum = mock_model(Forum)
        @post = mock_model(Post)
        @current_user = mock_model(User)
      end

      it "should display edit/delete links if current_user is the author" do
        helper.stub!(:current_user).and_return(@current_user)
        @post.stub!(:editable_by?).and_return(true)

        assigns[:post] = @post
        menu = helper.post_menu

        menu.should =~ /#{forum_posts_path(@forum)}/
        menu.should =~ /#{edit_forum_post_path(@forum, @post)}/
        menu.should =~ /delete/ # the spec is inaccuracy but works
      end

      it "should not display edit/delete links if current_user isn't the author" do
        helper.stub!(:current_user).and_return(@current_user)
        @post.stub!(:editable_by?).and_return(false)

        assigns[:post] = @post
        menu = helper.post_menu

        menu.should =~ /#{forum_posts_path(@forum)}/
        menu.should_not =~ /#{edit_forum_post_path(@forum, @post)}/
        menu.should_not =~ /delete/ # the spec is inaccuracy but works
      end
    end

    describe "#posts_menu" do
      it "display the posts menu" do
        menu = helper.posts_menu

        menu.should =~ /#{new_forum_post_path(@forum)}/
      end
    end
  end
end
