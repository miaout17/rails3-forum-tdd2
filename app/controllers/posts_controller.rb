class PostsController < ApplicationController
  
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :destroy]

  before_filter :find_forum
  before_filter :find_post,  :except => [:index, :new, :create]

  before_filter :editable_required!, :only => [:edit, :update, :destroy]

  def index
    @posts = @forum.posts
  end

  def show
  end

  def new
    @post = @forum.posts.build
  end

  def create
    @post = @forum.posts.build(params[:post])
    @post.user = current_user
    if @post.save
      redirect_to forum_post_path(@forum, @post)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to forum_post_path(@forum, @post)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to forum_posts_path(@forum)
  end

  protected

  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def find_post
    @post = @forum.posts.find(params[:id])
  end

  def editable_required!
    unless @post.editable_by?(current_user)
      flash.alert="You are unable to edit/delete the post" 
      redirect_to forum_post_path(@forum, @post)
    end
  end

end
