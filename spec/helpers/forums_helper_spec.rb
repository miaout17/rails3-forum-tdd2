require File.expand_path("../../spec_helper.rb", __FILE__)

describe ForumsHelper do
  describe "#new_forum_menu" do
    it "display the new_forum menu" do
      menu = helper.new_forum_menu

      menu.should =~ /#{forums_path}/
    end
  end

  describe "#forum_menu" do
    it "display the forum menu" do
      @forum = mock_model(Forum)
      assigns[:forum] = @forum
      menu = helper.forum_menu

      menu.should =~ /#{forums_path}/
    end
  end

  describe "#forums_menu" do
    it "display the forums menu" do
      menu = helper.forums_menu
    end
  end
end
