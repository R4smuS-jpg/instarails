class LikesController < ApplicationController
  before_action :authorize_action!, only: %i[create destroy]
  before_action :set_post, only: %i[create destroy]
  before_action :set_like, only: %i[destroy]

  def create
    @post.like_by(current_user)

    redirect_to @post
  end

  def destroy
    @post.unlike_by(current_user)

    redirect_to @post
  end

  private

  def authorize_action!
    authorize! with: LikePolicy
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_like
    @like = @post.likes.find_by(user_id: current_user.id)
  end
end
