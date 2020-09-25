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

  def get_age(birth)
    today = Date.current

    res = today.year - birth.year

    if res == 0
      'Menos de um ano'
    else
      "#{res} anos"
    end
  end
end
