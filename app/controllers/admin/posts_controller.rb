class Admin::PostsController < ApplicationController

  def index
    @posts = @forum.posts.sort_by_date.paginate :per_page => 20, :page => params[:page]
  end

  def edit
  end

  def show
  end

  def update
    if @post.update_attributes(params[:post])
      redirect_to(admin_forum_post_path(@forum, @post))
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to(admin_forum_posts_path(@forum))
  end

private
  def find_forum
    @forum = Forum.find(params[:forum_id])
  end

  def find_post
    @post = @forum.posts.find(params[:id])
  end

  before_filter :authenticate_user!

  before_filter :find_forum
  before_filter :find_post, :only => [:show, :edit, :update, :destroy]

  before_filter :admin_required!

end
