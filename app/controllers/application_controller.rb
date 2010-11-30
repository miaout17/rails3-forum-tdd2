class ApplicationController < ActionController::Base
  protect_from_forgery

private
  def admin_required!
    unless current_user.admin?
      flash.alert="Admin premission required"
      redirect_to "/"
    end
  end

end
