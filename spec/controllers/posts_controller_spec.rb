require File.expand_path("../../spec_helper.rb", __FILE__)
require File.expand_path("../../auth_spec_helper.rb", __FILE__)

describe PostsController do

  include AuthSpecHelperMethods

  def should_find_forum
    @forum = mock_model(Forum)
    controller.should_receive(:find_forum) { controller.instance_variable_set("@forum", @forum) }.ordered
  end

  def should_find_post
    @post  = mock_model(Post)
    controller.should_receive(:find_post ) { controller.instance_variable_set("@post",  @post)  }.ordered
  end

  def should_require_editable
    @post.should_receive(:editable_by?).with(@current_user).and_return(true)
  end

  def should_redirect_without_edit_premission
    @post.should_receive(:editable_by?).with(@current_user).and_return(false)
    yield
    response.should redirect_to(forum_post_path(@forum, @post))
  end

  describe "before_filter" do
    it "find_forum returns requested forum" do
      @forum = mock_model(Forum)
      controller.params = {:forum_id => 4}

      Forum.should_receive(:find).with(4).and_return(@forum)
      controller.send(:find_forum)

      assigns(:forum).should eq(@forum)
    end

    it "find_post returns requested post" do
      @forum = mock_model(Forum)
      @post  = mock_model(Post)
      @posts = []
      controller.params = {:forum_id => 4, :id => 3}
      controller.instance_variable_set("@forum", @forum)
      @forum.should_receive(:posts).and_return(@posts)
      @posts.should_receive(:find).with(3).and_return(@post)

      controller.send(:find_post)

      assigns(:forum).should eq(@forum)
      assigns(:post ).should eq(@post)
    end
  end

  describe "GET index" do
    it "returns all posts" do
      should_find_forum
      @posts = [mock_model(Post)]
      @forum.should_receive(:posts).and_return(@posts)

      get :index, :forum_id => 3

      assigns(:forum).should eq( @forum )
      assigns(:posts).should eq( @posts )
      response.should render_template("index")
    end
  end

  describe "GET show" do
    it "returns requested post" do
      should_find_forum
      should_find_post

      get :show, :forum_id => 4, :id => 3

      assigns(:forum).should eq( @forum )
      assigns(:post ).should eq( @post  )
      response.should render_template("show")
    end
  end

  describe "GET new" do
    it "returns a new post form" do
      should_authenticate_user
      should_find_forum
      @post  = mock_model(Post)
      @posts = []
      @forum.should_receive(:posts).and_return(@posts)
      @posts.should_receive(:build).and_return(@post)

      get :new, :forum_id => 4

      assigns(:forum).should eq(@forum)
      assigns(:post ).should eq(@post)
      response.should render_template("new")
    end
  end

  describe "POST create" do
    before :each do
      should_authenticate_user
      should_find_forum
      @post  = mock_model(Post)
      @posts = []
      @params = { "title" => Faker::Lorem.sentence }

      @forum.stub!(:posts).and_return(@posts)
      @posts.should_receive(:build).with(@params).and_return(@post)
      @post.should_receive(:user=).with(@current_user)
    end

    it "creates successfully" do
      @post.should_receive(:save).and_return(true)

      post :create, {:forum_id => 4, :post => @params}

      response.should redirect_to(forum_post_path(@forum, @post))
    end

    it "fails to create" do
      @post.should_receive(:save).and_return(false)

      post :create, {:forum_id => 4, :post => @params}

      assigns(:forum).should eq(@forum)
      assigns(:post ).should eq(@post)
      response.should render_template("new")
    end
  end

  describe "GET edit" do
    before(:each) do
      should_authenticate_user
      should_find_forum
      should_find_post
    end
    
    it "returns requested post" do
      should_require_editable

      get :edit, :forum_id => 4, :id => 3

      assigns(:forum).should eq( @forum )
      assigns(:post ).should eq( @post  )
      response.should render_template("edit")
    end

    it "should redirect without edit premission" do
      should_redirect_without_edit_premission do
        delete :destroy, {:forum_id => 4, :id => 3}
      end
    end

  end

  describe "PUT update" do
    before :each do
      should_authenticate_user
      should_find_forum
      should_find_post
      @params = { "title" => Faker::Lorem.sentence }
    end

    it "update successfully with valid params" do
      should_require_editable
      @post.should_receive(:update_attributes).with(@params).and_return(true)

      get :update, {:forum_id => 4, :id => 3, :post => @params}

      response.should redirect_to(forum_post_path(@forum, @post))
    end

    it "fails to update with invalid params" do
      should_require_editable
      @post.should_receive(:update_attributes).with(@params).and_return(false)

      get :update, {:forum_id => 4, :id => 3, :post => @params}

      assigns(:forum).should eq(@forum)
      assigns(:post ).should eq(@post)
      response.should render_template("edit")
    end

    it "should redirect without edit premission" do
      should_redirect_without_edit_premission do
        get :update, {:forum_id => 4, :id => 3, :post => @params}
      end
    end
  end

  describe "DELETE destroy" do
    before(:each) do
      should_authenticate_user
      should_find_forum
      should_find_post
    end

    it "destroys the requested post" do
      should_require_editable

      @post.should_receive(:destroy).and_return(true)

      delete :destroy, {:forum_id => 4, :id => 3}

      response.should redirect_to(forum_posts_path(@forum))
    end

    it "should redirect without edit premission" do
      should_redirect_without_edit_premission do
        get :update, {:forum_id => 4, :id => 3, :post => @params}
      end
    end
  end

end
