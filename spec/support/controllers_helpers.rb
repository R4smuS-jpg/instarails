module ControllersHelpers
  def sign_in_as(user)
    cookies.encrypted[:current_user_id] = user.id
  end

  def signed_in?
    cookies[:current_user_id].present?
  end
end

RSpec.configure do |config|
  config.include ControllersHelpers, type: :controller
end

