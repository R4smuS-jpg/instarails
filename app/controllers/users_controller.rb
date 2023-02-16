class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authorize_user!, only: %i[show edit update destroy]
  
  def index
    @users = User.all
    authorize! @users
  end

  def new
    authorize!

    @user = User.new
  end

  def create
    authorize!

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
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:success] = 'You have successfully updated your account'
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'You have successfully deleted your account'
    sign_out
    redirect_to root_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    authorize! @user
  end

  def user_params
    params.require(:user).permit(:email,
                                 :nickname,
                                 :full_name,
                                 :password,
                                 :password_confirmation)
  end
end
