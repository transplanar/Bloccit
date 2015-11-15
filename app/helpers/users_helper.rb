module UsersHelper


  def has_posts(user)
    user.posts.count > 0
  end
end
