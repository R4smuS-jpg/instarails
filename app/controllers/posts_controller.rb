class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :authorize_post!, only: %i[show edit update destroy]

  def index
    @posts = Post.all
    authorize! @posts
  end

  def new
    authorize!

    @post = Post.new
  end

  def create
    authorize!

    @post = current_user.posts.build(post_params)

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
      render :new
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

  def authorize_post!
    authorize! @post
  end

  def post_params
    params.require(:post).permit(:content,
                                 images: [])
  end
end
