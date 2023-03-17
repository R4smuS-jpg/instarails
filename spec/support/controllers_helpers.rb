module ControllersHelpers
  def sign_in_as(user)
    cookies.encrypted[:current_user_id] = user.id
  end
end

RSpec.configure do |config|
  config.include ControllersHelpers, type: :controller
end

