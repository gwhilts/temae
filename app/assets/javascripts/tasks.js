var filterTasks = function() {
  $('.task.unavailable').hide();
  $('.context').each( function() {
    if( $(this).find('.available').size() == 0 ) {
      $(this).hide();
    }
  });
}

var showAllTasks = function() {
  $('.context').show();
  $('.task').show();
}
