class UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  before_action :authorize_user!, only: %i[show]
  before_action :authorize_current_user!, only: %i[edit
                                                   update
                                                   destroy
                                                   delete_avatar]

  before_action :authorize_action!, only: %i[new
                                             create]

  def index
    @pagy, @users = pagy(User.by_created_at(:desc))
    authorize! @users
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'You have successfully signed up'
      sign_in(@user)
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @pagy, @posts = pagy(@user.posts.by_created_at(:desc)
                                .with_attached_images
                                .with_comments_with_user_with_attached_avatar)
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      flash[:success] = 'You have successfully updated your account'
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    current_user.destroy
    flash[:success] = 'You have successfully deleted your account'
    sign_out
    redirect_to root_path
  end

  def delete_avatar
    unless current_user.avatar.blank?
      current_user.delete_avatar
      flash[:success] = 'You have successfully deleted your avatar'
      redirect_to current_user
    else
      # kostil' =)
      flash[:success] = 'You have successfully deleted your avatar'
      render :edit
    end
  end

  private

  # should be called if action works with any user
  def set_user
    @user = User.find(params[:id])
  end

  # should be called if policy of action needs a variable
  def authorize_user!
    authorize! @user
  end

  # should be called if action works with current user
  def authorize_current_user!
    authorize! current_user
  end

  # should be called if action must be authenticated
  # but does not have variable that policy needs to get
  def authorize_action!
    authorize!
  end

  def user_params
    params.require(:user).permit(:email,
                                 :nickname, 
                                 :avatar,
                                 :full_name,
                                 :password,
                                 :password_confirmation)
  end
end
