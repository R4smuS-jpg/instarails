class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]
  before_action :set_like, only: %i[destroy]

  def create
    authorize!

    @post.like_by(current_user)

    redirect_to @post
  end

  def destroy
    authorize!

    @post.unlike_by(current_user)

    redirect_to @post
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = @post.likes.find_by(user_id: current_user.id)
  end
end
