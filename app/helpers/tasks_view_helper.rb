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

  def task_complete_status(completed)
    completed ? "complete" : "incomplete"
  end
end

