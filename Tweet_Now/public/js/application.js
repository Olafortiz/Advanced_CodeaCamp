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
    $.post("/user", {username: userName}, function(data){
      $('#tweets').show();
      $('#tweets').html(data);
      $('#handle').empty();
      $loading.hide();
    }); 
  });

  sendTweet();

});


var sendTweet = function(){
  $('#send').submit(function(event){
    event.preventDefault();
    var tweetVal = $('textarea#tweet').val();
    $.post("/tweet", {tweet: tweetVal}, function(data){
      console.log(data);
      $("#hola").append(data);
      $('#send').trigger("reset");
    });
  });
}




