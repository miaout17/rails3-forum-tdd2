class Admin::ForumsController < ApplicationController

  def index
    @forums = Forum.all
  end

  def new
    @forum = Forum.new
  end

  def show
    redirect_to(admin_forum_posts_path(@forum))
  end

  def edit
  end

  def create
    @forum = Forum.new(params[:forum])
    if @forum.save
      redirect_to(admin_forum_posts_path(@forum))
    else
      render "new"
    end
  end

  def update
    if @forum.update_attributes(params[:forum])
      redirect_to(admin_forum_posts_path(@forum))
    else
      render "edit"
    end
  end

  def destroy
    @forum.destroy
    redirect_to(admin_forums_path)
  end

private
  def find_forum
    @forum = Forum.find(params[:id])
  end

  before_filter :authenticate_user!
  before_filter :admin_required!

  before_filter :find_forum, :only => [:show, :edit, :update, :destroy]

end
