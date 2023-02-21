module Authentication
  extend ActiveSupport::Concern

  included do
    helper_method :signed_in?,
                  :current_user
  end

  def sign_in(user)
    cookies.encrypted[:current_user_id] = user.id
  end

  def sign_out
    byebug
    cookies.delete(:current_user_id)
    @current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: cookies.encrypted[:current_user_id])
  end
end
