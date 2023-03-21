class CommentsController < ApplicationController
  before_action :authorize_action!, only: %i[create edit update destroy]
  before_action :set_post, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]
  # before_action :authorize_comment!, only: %i[edit update destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to @post
    else
      add_comment_fields_errors_to_flash
      redirect_to @post
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      flash[:success] = 'You have successfully updated your comment'
      redirect_to @post
    else
      add_comment_fields_errors_to_flash
      redirect_to @post
    end
  end

  def destroy
    @comment.destroy  
    flash[:success] = 'You have successfully deleted your comment'
    redirect_to @post
  end

  private

  def add_comment_fields_errors_to_flash
    flash[:danger] = @comment.errors
                         .full_messages
                         .map { |e| "Comment's #{e.downcase}" }
                         .join('. ')
  end

  def set_comment
    @comment = @post.comments.where(user_id: current_user.id).find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def authorize_comment!
    authorize! @comment
  end

  def authorize_action!
    authorize! with: CommentPolicy
  end

  def comment_params
    params.require(:comment).permit(:content)
                            .merge(user_id: current_user.id)
  end
end
