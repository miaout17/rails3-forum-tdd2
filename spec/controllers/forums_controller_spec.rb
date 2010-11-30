require File.expand_path("../../spec_helper.rb", __FILE__)

describe ForumsController do

  def should_find_forum
    @forum = mock_model(Forum)
    controller.should_receive(:find_forum) { controller.instance_variable_set("@forum", @forum) }.ordered
  end

  describe "before_filter" do
    it "find_forum returns requested forum" do
      @forum = mock_model(Forum)
      controller.params = {:id => 4}

      Forum.should_receive(:find).with(4).and_return(@forum)
      controller.send(:find_forum)

      assigns(:forum).should eq(@forum)
    end
  end

  describe "GET index" do
    it "returns all forums" do
      @forums = [ mock_model(Forum) ]
      Forum.stub(:all) { @forum }

      get :index

      assigns(:forums).should eq( @forum )
      response.should render_template("index")
    end
  end

  describe "GET show" do
    it "redirect to forum_forums" do
      should_find_forum

      get :show, :id => 3

      response.should redirect_to(forum_posts_path(@forum))
    end
  end
end
