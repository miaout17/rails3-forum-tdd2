module ForumsHelper
  def new_forum_menu
    nav_tag(
      content_tag(:ul,
        content_tag(:li, link_to("Forum list", forums_path))
      )
    )
  end

  def forum_menu
    nav_tag(
      content_tag(:ul) do
        concat content_tag(:li, link_to("Forum list", forums_path))
        concat content_tag(:li, link_to("Edit forum", edit_forum_path(@forum)))
        concat content_tag(:li, link_to("Destroy forum", forum_path(@forum), :method => :delete))
      end
    )
  end

  def forums_menu
    nav_tag(
      content_tag(:ul,
        content_tag(:li, link_to("New forum", new_forum_path))
      )
    )
  end

  private
  def nav_tag(content)
    content_tag(:div, content, :id => "nav")
  end
end
