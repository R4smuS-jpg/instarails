class LikesController < ApplicationController
  before_action :set_post, only: %i[create destroy]
  before_action :set_like, only: %i[destroy]

  def method_name
    
  end

  def create
    authorize!

    @like = @post.likes.new(post_id: @post.id,
                            user_id: current_user.id)
    @like.save
    redirect_to @post
  end

  def destroy
    authorize! @like
    @like.destroy
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
