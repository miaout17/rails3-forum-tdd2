require 'spec_helper'

describe Admin::ForumsHelper do
  describe "#admin_new_forum_menu" do
    it "display the new_forum menu" do
      menu = helper.admin_new_forum_menu

      menu.should =~ /#{admin_forums_path}/
    end
  end

  describe "#admin_forum_menu" do
    it "display the forum menu" do
      @forum = mock_model(Forum)
      assigns[:forum] = @forum
      menu = helper.admin_forum_menu

      menu.should =~ /#{admin_forums_path}/
      menu.should =~ /#{edit_admin_forum_path(@forum)}/
      menu.should =~ /#{admin_forum_path(@forum)}/
    end
  end

  describe "#forums_menu" do
    it "display the forums menu" do
      menu = helper.admin_forums_menu

      menu.should =~ /#{new_admin_forum_path}/
    end
  end
end
