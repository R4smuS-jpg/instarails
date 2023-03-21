class FollowingsController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :already_following
  rescue_from ActiveRecord::RecordNotFound, with: :not_following

  before_action :authorize_action!, only: %i[create destroy]

  def create
    @user = User.find(params[:id])
    current_user.follow(@user)
    flash[:success] = "Now you follow #{@user.nickname}"
    redirect_to @user
  end

  def destroy
    @user = current_user.followings.find(params[:id])
    current_user.unfollow(@user)
    flash[:success] = "You do not follow #{@user.nickname} anymore"
    redirect_to current_user
  end

  private

  def authorize_action!
    authorize! with: FollowingPolicy
  end

  def already_following
    flash[:danger] = "You already follow #{@user.nickname}"
    redirect_to @user
  end

  def not_following
    flash[:danger] =
      "You do not follow #{User.find(params[:id]).nickname} to unfollow"
    redirect_to current_user
  end
end
