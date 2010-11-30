module ApplicationHelper
  def auth_menu
    if user_signed_in? 
      links = [
        link_to("Sign out", destroy_user_session_path)
      ]
    else
      links = [
        link_to("Sign in", new_user_session_path), 
        link_to("Sign up", new_user_registration_path)
      ]
    end

    content_tag(:div, :class => "auth-menu") do
      if user_signed_in? 
        concat "Welcome #{current_user.email}" 
      else
        concat "You are not logged in" 
      end
      links.each do |link|
        concat content_tag(:div, link)
      end
    end
  end
end
