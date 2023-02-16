class SessionsController < ApplicationController
  before_action :authorize_session!, only: %i[new create destroy]

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
    redirect_to root_path
  end

  private

  def authorize_session!
    authorize! with: SessionPolicy
  end
end
