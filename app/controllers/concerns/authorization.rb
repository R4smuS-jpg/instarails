module Authorization
  extend ActiveSupport::Concern

  included do
    helper_method :correct_user?
  end

  def redirect_if_incorrect_user
    unless correct_user?
      flash[:alert] = 'You are not permitted to do that'
      redirect_to current_user
    end
  end
  
  def correct_user?
    User.find(params[:id]) == current_user
  end
end
