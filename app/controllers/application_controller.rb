class ApplicationController < ActionController::Base
  protect_from_forgery

  # concerns
  include Authentication
  include ErrorHandling
end
