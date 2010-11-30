class ForumsController < ApplicationController
  before_filter :find_forum, :only => [:show]

  def index
    @forums = Forum.all
  end

  def show
    redirect_to forum_posts_path(@forum)
  end

  protected
  def find_forum
    @forum = Forum.find(params[:id])
  end
end
