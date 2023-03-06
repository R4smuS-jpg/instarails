# module for handling exceptions
module ErrorHandling
  extend ActiveSupport::Concern

  included do
    include ActionPolicy

    rescue_from ActionPolicy::Unauthorized, with: :not_authorized
    rescue_from ActiveRecord::RecordNotFound, with: :notfound
    # does not work for some reason =/
    # rescue_from ActionController::RoutingError, with: :notfound

    private

    def notfound
      render file: 'public/404.html', status: :not_found, layout: false
    end

    def not_authorized
      path = request.path
      sign_out_required_paths = %w[/sign-in sign-up]

      if sign_out_required_paths.include?(path)
        handle_sign_out_required
      else
        handler_not_authorized
      end
    end

    # user not authorized handlers
    def handle_sign_out_required
      flash[:success] = "You are signed in already"
      redirect_to current_user
    end

    def handler_not_authorized
      flash[:danger] = 'You are not allowed to perform this action'
      redirect_to root_path
    end
  end
end
