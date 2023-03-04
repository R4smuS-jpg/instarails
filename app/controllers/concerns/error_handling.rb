# module for handling exceptions
module ErrorHandling
  extend ActiveSupport::Concern

  included do
    include ActionPolicy

    # rescue_from ActiveRecord::RecordNotFound, with: :page_not_found
    rescue_from ActionPolicy::Unauthorized, with: :user_not_authorized

    private

    def page_not_found
      render file: 'public/404.html', status: :not_found, layout: false
    end

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
    end
  end
end
