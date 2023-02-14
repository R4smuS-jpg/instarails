module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?, 
                  :current_user
  end

  def sign_in(user)
    session[:current_user_id] = user.id
  end

  def sign_out
    session.delete(:current_user_id)
    @current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:current_user_id])
  end

  def redirect_if_not_signed_in
    unless signed_in?
      flash[:alert] = 'You need to sign in to do that'
      redirect_to sign_in_path
    end
  end

  def redirect_if_signed_in
    if signed_in?
      flash[:alert] = 'You are authenticated already'
      redirect_to current_user
    end
  end
end
