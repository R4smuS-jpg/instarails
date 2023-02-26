module PostsHelper
  def post_belongs_to_current_user(post)
    post.user == current_user
  end

  def post_with_username_link?(page)
    pages_with_username_link = [:all_posts, :post]

    pages_with_username_link.include?(page)
  end

  def post_with_avatar_link?(page)
    pages_with_avatar_link = [:all_posts, :post]

    pages_with_username_link.include?(page)
  end
end
