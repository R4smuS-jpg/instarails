class ApplicationController < ActionController::Base
  protect_from_forgery

  # concerns
  include Authentication

  # rescue NotAuthorized exception
  include ActionPolicy

  rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized

  private

  def user_not_authorized
    case request.path
    when '/sign-in'
      flash[:success] = "You are signed in already"
      redirect_to current_user
    when '/sign-up'
      flash[:success] = "You are signed in already"
      redirect_to current_user
    when '/edit-account'
      flash[:danger] = "You must be signed in to perform this action"
      redirect_to current_user
    when '/delete-account'
      flash[:danger] = "You must be signed in to perform this action"
      redirect_to current_user
    end
      
      


    # flash[:danger] = "You are not authorized to perform this action"
    # redirect_to(request.referrer || root_path)
  end
end
