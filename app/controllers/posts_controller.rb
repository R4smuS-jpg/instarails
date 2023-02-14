class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      flash[:success] = 'You have successfully created new post'
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post
      flash[:success] = 'You have successfully updated your post'
    else
      render.new
    end
  end

  def destroy
    @post.destroy
    flash[:success] = 'You have successfully deleted your post'
    redirect_to @post.user
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:user_id,
                                 :content,
                                 images: [])
                         .merge(user_id: current_user.id)
  end
end
