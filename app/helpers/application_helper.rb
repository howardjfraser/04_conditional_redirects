module ApplicationHelper
  def app_number
    APP_NUMBER
  end

  def app_name
    APP_NAME
  end

  def title
    "#{app_number} #{app_name}"
  end

  def label_or_error(form_builder, field)
    object = form_builder.object
    form_builder.label field, object.errors.full_messages_for(field)[0]
  end
end
