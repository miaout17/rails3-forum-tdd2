module Admin::PostsHelper

  def admin_new_post_menu
    nav_tag(
      content_tag(:ul,
        content_tag(:li, link_to("Post list", admin_forum_posts_path(@forum)))
      )
    )
  end

  def admin_post_menu
    nav_tag(
      content_tag(:ul) do
        concat content_tag(:li, link_to("Post list", admin_forum_posts_path(@forum)))
        concat content_tag(:li, link_to("Edit post", edit_admin_forum_post_path(@forum, @post)))
        concat content_tag(:li, link_to("Destroy post", admin_forum_post_path(@forum, @post), :method => :delete))
      end
    )
  end

  def admin_posts_menu
    nav_tag(
      content_tag(:ul) do
        concat content_tag(:li, link_to("Forum list", admin_forums_path))
        concat content_tag(:li, link_to("Edit forum", edit_admin_forum_path(@forum)))
        concat content_tag(:li, link_to("Destroy forum", admin_forum_path(@forum), :method => :delete))
      end
    )
  end

  private
  def nav_tag(content)
    content_tag(:div, content, :id => "nav")
  end

end
