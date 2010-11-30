require 'spec_helper'

describe Admin::PostsHelper do
  describe "menu" do
    before :each do
      @forum = mock_model(Forum)
      assigns[:forum] = @forum
    end

    describe "#admin_new_post_menu" do
      it "display the new_post menu" do
        menu = helper.admin_new_post_menu

        menu.should =~ /#{admin_forum_posts_path(@forum)}/
      end
    end

    describe "#admin_post_menu" do

      it "display the post menu" do
        @forum = mock_model(Forum)
        @post = mock_model(Post)

        assigns[:post] = @post
        menu = helper.admin_post_menu

        menu.should =~ /#{admin_forum_posts_path(@forum)}/
        menu.should =~ /#{edit_admin_forum_post_path(@forum, @post)}/
        menu.should =~ /delete/ # the spec is inaccuracy but works
      end
    end

    describe "#posts_menu" do
      it "display the posts menu" do
        menu = helper.admin_posts_menu

        menu.should =~ /#{admin_forums_path}/
        menu.should =~ /#{edit_admin_forum_path(@forum)}/
        menu.should =~ /#{admin_forum_path(@forum)}/
      end
    end
  end

end
