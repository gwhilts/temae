module TasksViewHelper
  def task_date_status(day)
    case
    when day == nil
      "unspecified"
    when day.today?
      "today"
    when day.past?
      "past"
    else
      "future"
    end
  end

  def context_selector(list, task, options = {})
    if task.context
      selected = task.context.id
    end

    html_attrs = ' id="task_context_id" name="task[context_id]"'

    options.each do |key, val|
      html_attrs << " #{key}=\"#{val}\""
    end

    el = "<select#{html_attrs}>"

    list.each do | key, text |
      if key == selected
        el << "<option selected value=\"#{key}\">#{text}</option>"
      else
        el << "<option value=\"#{key}\">#{text}</option>"
      end
    end
    
    el << '</select>'

    el.html_safe
  end
end

