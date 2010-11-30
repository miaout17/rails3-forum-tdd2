require 'spec_helper'
require 'auth_spec_helper'

describe Admin::PostsController do
  include AuthSpecHelperMethods

  def should_find_forum
    @forum = mock_model(Forum)
    controller.should_receive(:find_forum) { controller.instance_variable_set("@forum", @forum) }.ordered
  end

  def should_find_post
    @post  = mock_model(Post)
    controller.should_receive(:find_post) { controller.instance_variable_set("@post",  @post)  }.ordered
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
    before(:each) do
      should_authenticate_user
      should_find_forum
    end

    it "returns posts sorted by date" do
      should_require_admin
      @posts = [mock_model(Post)]
      @forum.should_receive(:posts).and_return(@posts)
      @posts.should_receive(:sort_by_date).and_return(@posts)
      @posts.should_receive(:paginate).with(:per_page => 20, :page => 6).and_return(@posts)

      get :index, :forum_id => 3, :page => 6

      assigns(:forum).should eq( @forum )
      assigns(:posts).should eq( @posts )
      response.should render_template("index")
    end

    it "should redirect without edit premission" do
      should_redirect_without_admin_premission do
        get :index, :forum_id => 3, :page => 6
      end
    end
  end 

  describe "GET edit" do
    before(:each) do
      should_authenticate_user
      should_find_forum
      should_find_post
    end

    it "should redirect without admin premission" do
      should_redirect_without_admin_premission do
        get :edit, :forum_id => 4, :id => 3
      end
    end

    it "returns requested post" do
      should_require_admin

      get :edit, :forum_id => 4, :id => 3

      assigns(:forum).should eq( @forum )
      assigns(:post ).should eq( @post  )
      response.should render_template("edit")
    end
  end

  describe "PUT update" do
    before :each do
      should_authenticate_user
      should_find_forum
      should_find_post
      @params = { "title" => Faker::Lorem.sentence }
    end

    it "should redirect without admin premission" do
      should_redirect_without_admin_premission do
        get :update, {:forum_id => 4, :id => 3, :post => @params}
      end
    end

    it "update successfully with valid params" do
      should_require_admin
      @post.should_receive(:update_attributes).with(@params).and_return(true)

      get :update, {:forum_id => 4, :id => 3, :post => @params}

      response.should redirect_to(admin_forum_post_path(@forum, @post))
    end

    it "fails to update with invalid params" do
      should_require_admin
      @post.should_receive(:update_attributes).with(@params).and_return(false)

      get :update, {:forum_id => 4, :id => 3, :post => @params}

      assigns(:forum).should eq(@forum)
      assigns(:post ).should eq(@post)
      response.should render_template("edit")
    end
  end

  describe "GET show" do

    before(:each) do
      should_authenticate_user
      should_find_forum
      should_find_post
    end

    it "returns requested post" do
      should_require_admin

      get :show, :forum_id => 4, :id => 3

      assigns(:forum).should eq( @forum )
      assigns(:post ).should eq( @post  )
      response.should render_template("show")
    end
  end 

  describe "DELETE destroy" do
    before(:each) do
      should_authenticate_user
      should_find_forum
      should_find_post
    end

    it "should redirect without admin premission" do
      should_redirect_without_admin_premission do
        delete :destroy, {:forum_id => 4, :id => 3}
      end
    end

    it "destroys the requested post" do
      should_require_admin

      @post.should_receive(:destroy).and_return(true)

      delete :destroy, {:forum_id => 4, :id => 3}
      response.should redirect_to(admin_forum_posts_path(@forum))
    end
  end

end
