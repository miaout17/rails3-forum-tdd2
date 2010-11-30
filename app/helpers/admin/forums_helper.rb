module Admin::ForumsHelper
  def admin_new_forum_menu
    nav_tag(
      content_tag(:ul,
        content_tag(:li, link_to("Forum list", admin_forums_path))
      )
    )
  end

  def admin_forum_menu
    nav_tag(
      content_tag(:ul) do
        concat content_tag(:li, link_to("Forum list", admin_forums_path))
        concat content_tag(:li, link_to("Edit forum", edit_admin_forum_path(@forum)))
        concat content_tag(:li, link_to("Destroy forum", admin_forum_path(@forum), :method => :delete))
      end
    )
  end

  def admin_forums_menu
    nav_tag(
      content_tag(:ul,
        content_tag(:li, link_to("New forum", new_admin_forum_path))
      )
    )
  end

  private
  def nav_tag(content)
    content_tag(:div, content, :id => "nav")
  end
end
