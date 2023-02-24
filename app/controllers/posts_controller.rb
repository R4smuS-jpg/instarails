class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  before_action :set_current_user_post, only: %i[edit
                                                 update
                                                 destroy]

  before_action :authorize_post!, only: %i[show
                                           edit
                                           update
                                           destroy]

  before_action :authorize_action!, only: %i[new
                                             create]

  def index
    @posts = Post.by_created_at(:desc)
    authorize! @posts
  end

  def new
    @post = current_user.posts.new
  end

  def create
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

  # should be called if action works with any user's post
  def set_post
    @post = Post.find(params[:id])
  end

  # should be called if action works with current user's post
  def set_current_user_post
    @post = current_user.posts.find(params[:id])
  end

  # should be called if policy of action needs a variable
  def authorize_post!
    authorize! @post
  end

  # should be called if action must be authenticated
  # but does not have variable that policy needs to get
  def authorize_action!
    authorize!    
  end

  def post_params
    params.require(:post).permit(:content, images: [])
  end
end
