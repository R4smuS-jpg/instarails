module ApplicationHelper
  # pagy gem
  include Pagy::Frontend

  def field_has_error(model, field_name)
    model.errors[field_name].empty? ? '' : 'input-error'
  end
end
