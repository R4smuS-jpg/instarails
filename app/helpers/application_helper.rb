module ApplicationHelper
  def field_has_error(model, field_name)
    model.errors[field_name].empty? ? '' : 'input-error'
  end
end
