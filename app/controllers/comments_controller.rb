class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_post, only: %i[create edit update destroy]
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to @post
    else
      flash[:danger] = @comment.errors
                               .full_messages
                               .map { |e| "Comment's #{e.downcase}"}
                               .join('. ')
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
      flash[:danger] = @comment.errors
                               .full_messages
                               .map { |e| "Comment's #{e.downcase}"}
                               .join('. ')
      redirect_to @post
    end
  end

  def destroy
    @comment.destroy  
    flash[:success] = 'You have successfully deleted your comment'
    redirect_to @post
  end

  private

  def set_comment
    @comment = @post.comments.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
                            .merge(user_id: current_user.id)
  end
end
