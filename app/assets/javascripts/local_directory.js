$(document).ready(function(){
  $("button.generate_directory").on('click', function(e){
    e.preventDefault();
    var id = $(this).data('id');
    console.log(id);
    $(this).replaceWith("<span>cool. the directory will be saved in this feed's folder in your local Own-Your-Stuff directory.</span>");
    $.post('/local', {id: id}, function(){})
  })
})
