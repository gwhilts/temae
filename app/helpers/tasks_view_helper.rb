module TasksViewHelper
  def nested_context_menu(contexts)
    html =  '<ul class="menu vertical sublevel-1">'
    html << "<li>#{ link_to 'All', root_path, class: 'subitem' }</li>"
    contexts.each do |ctx|
      unless ctx.parent || ctx.name == 'Inbox'
        html << "<li>#{ link_to ctx.name, tasks_by_context_path(id: ctx.id), class: 'subitem', data: {icon: ctx.icon} }</li>"
        if ctx.children.count > 0
          html << '<ul class="menu vertical sublevel-2">'
          ctx.children.each do |child|
            html << "<li>#{ link_to child.name, tasks_by_context_path(id: child.id), class: 'subitem', data: {icon: child.icon} }</li>"
          end
          html << '</ul>'
        end
      end
    end
    html << '</ul>'
    html
  end

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

