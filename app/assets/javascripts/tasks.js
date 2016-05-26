var filterTasks = function() {
  $('.task.unavailable').hide();
  $('.task-group').each( function() {
    if( $(this).find('.available').size() == 0 ) {
      $(this).hide();
    }
  });
}

var showAllTasks = function() {
  $('.task-group').show();
  $('.task').show();
}
