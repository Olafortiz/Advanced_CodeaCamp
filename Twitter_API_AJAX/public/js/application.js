$(document).ready(function() {
	// Este código corre después de que `document` fue cargado(loaded) 
	// completamente. 
	// Esto garantiza que si amarramos(bind) una función a un elemento 
	// de HTML este exista ya en la página. 
  $("#tweets").hide();
  var $loading = $('#spinner').hide();
      
  
  $("#handle").on("submit", function(event){

    $loading.show();
    event.preventDefault();
    var userName = $('#username').val();
    console.log(userName);
    $.post("/user", {username: userName}, function(data){
      console.log(data);
      $('#tweets').show();
      $('#tweets').html(data);
      $('#handle').empty();
      $loading.hide();
    }); 
  
  });
});




