class ApplicationController < ActionController::Base
  protect_from_forgery

  # concerns
  include Authentication
  include ErrorHandling

  # pagy gem
  include Pagy::Backend
end
