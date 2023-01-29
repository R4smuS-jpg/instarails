class SessionsController < ApplicationController
  def new
    redirect_to current_user if signed_in?
  end

  def create
    unless signed_in?
      user = User.find_by(email: params[:session][:email])

      if user&.authenticate(params[:session][:password])
        sign_in(user)
        flash[:success] = 'You have successfully signed in'
        redirect_to user
      else
        flash.now[:alert] = 'Incorrect email/password combination'
        render :new
      end
    end
  end

  def destroy
    if signed_in?
      sign_out
      flash[:success] = 'You have successfully signed out'
    end
    
    redirect_to root_path
  end
end
