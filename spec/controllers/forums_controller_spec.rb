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

  describe "GET new" do
    it "returns a new forum form" do
      @forum = mock_model(Forum)
      Forum.should_receive(:new).and_return(@forum)

      get :new

      assigns(:forum).should eq(@forum)
      response.should render_template("new")
    end
  end

  describe "POST create" do
    it "creates successfully" do
      @forum = mock_model(Forum)
      @params = { "title" => Faker::Lorem.sentence }
      Forum.should_receive(:new).with(@params).and_return(@forum)
      @forum.should_receive(:save).and_return(true)

      post :create, {:forum => @params}

      response.should redirect_to(forum_posts_path(@forum))
    end

    it "fails to create" do
      @forum = mock_model(Forum)
      @params = { "title" => Faker::Lorem.sentence }
      Forum.should_receive(:new).with(@params).and_return(@forum)
      @forum.should_receive(:save).and_return(false)

      post :create, {:forum => @params}

      assigns(:forum).should eq(@forum)
      response.should render_template("new")
    end
  end

  describe "GET show" do
    it "redirect to forum_forums" do
      should_find_forum

      get :show, :id => 3

      response.should redirect_to(forum_posts_path(@forum))
    end
  end

  describe "GET edit" do
    it "returns requested forum" do
      should_find_forum

      get :edit, :id => 3

      assigns(:forum).should eq(@forum)
      response.should render_template("edit")
    end
  end

  describe "PUT update" do
    it "update successfully with valid params" do
      should_find_forum
      @params = { "title" => Faker::Lorem.sentence }
      @forum.should_receive(:update_attributes).with(@params).and_return(true)

      put :update, {:id => 3, :forum => @params}

      response.should redirect_to(forum_posts_path(@forum))
    end

    it "fails to update with invalid params" do
      should_find_forum
      @params = { "title" => Faker::Lorem.sentence }
      @forum.should_receive(:update_attributes).with(@params).and_return(false)

      put :update, {:id => 3, :forum => @params}

      assigns(:forum).should eq(@forum)
      response.should render_template("edit")
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested forum" do
      should_find_forum
      @forum.should_receive(:destroy).and_return(true)

      delete :destroy, {:id => 3}

      response.should redirect_to(forums_path)
    end
  end
end
