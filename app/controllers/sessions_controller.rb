class SessionsController < ApplicationController
  before_action :redirect_if_not_signed_in, only: %i[destroy]
  before_action :redirect_if_signed_in, only: %i[new create]

  def new
  end

  def create
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

  def destroy
    flash[:success] = 'You have successfully signed out'
    sign_out
  end
end
