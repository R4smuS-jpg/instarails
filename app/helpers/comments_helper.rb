module CommentsHelper
  def comment_belongs_to_current_user?(comment)
    comment.user == current_user
  end
end
