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
end
