module UsersHelper


  def has_posts(user)
    user.posts.count > 0
  end

  def render_posts_for(user)
    if user.posts.any?
      render(user.posts).html_safe
    else
      "<p>This user doesn't have any posts yet.</p>".html_safe
    end
  end
end
