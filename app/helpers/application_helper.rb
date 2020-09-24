module ApplicationHelper
  def flash_message_class(level)
    case level.to_s
    when 'notice'
      'alert-success'
    when 'success'
      'alert-success'
    when 'info'
      'alert-info'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-danger'
    when 'danger'
      'alert-danger'
    end
  end
end
