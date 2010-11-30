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
      end
    )
  end

  def forums_menu
    nav_tag(
      content_tag(:ul, "")
    )
  end

  private
  def nav_tag(content)
    content_tag(:div, content, :id => "nav")
  end
end
