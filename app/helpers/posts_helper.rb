module PostsHelper
  def new_post_menu
    nav_tag(
      content_tag(:ul,
        content_tag(:li, link_to("Post list", forum_posts_path(@forum)))
      )
    )
  end

  def post_menu
    nav_tag(
      content_tag(:ul) do
        concat content_tag(:li, link_to("Post list", forum_posts_path(@forum)))
        concat content_tag(:li, link_to("Edit post", edit_forum_post_path(@forum, @post)))
        concat content_tag(:li, link_to("Destroy post", forum_post_path(@forum, @post), :method => :delete))
      end
    )
  end

  def posts_menu
    nav_tag(
      content_tag(:ul) do
        concat content_tag(:li, link_to("Forum list", forums_path))
        concat content_tag(:li, link_to("Edit forum", edit_forum_path(@forum)))
        concat content_tag(:li, link_to("Destroy forum", forum_path(@forum), :method => :delete))
        concat content_tag(:li, link_to("New post", new_forum_post_path(@forum)))
      end
    )
  end

  private
  def nav_tag(content)
    content_tag(:div, content, :id => "nav")
  end
end
