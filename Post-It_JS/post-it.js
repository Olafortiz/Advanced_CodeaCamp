var Board = function( selector ) {
  // Aqui denerá ir el código que tenga que ver con tu tablero 
  
  // Utiliza esta sintaxis para referirte al selector que representa al tablero.
  // De esta manera no dependerás tanto de tu HTML.  
  elem = $(selector);
  
  function initialize() {
    // Que debe de pasar cuando se crea un nuevo tablero?
  };

  initialize();
};

var PostIt = function(number) {
  // Aquí va el código relacionado con un post-it
  this.post = '<div class="post-it" id="'+number+'"><div class="header"><a href="#">X</a></div><div contenteditable="true" class="content">...</div></div>';
};

$(function() {
  // Esta es la fucnión que correrá cuando este listo el DOM
  num = 1; 
  $('#0').draggable({handle: '.header'});
  CreatePostIt();
  PasstoFront();
  StopCreating();
  DeletePost();
});

var CreatePostIt = function(){
  $("#board").dblclick(function(e){
    newPostIt = new PostIt(num);
    dragPost = $(newPostIt.post).css({ 'left': e.pageX, 'top': e.pageY }).appendTo('#board');
    $(dragPost).draggable({handle: '.header'}); 
    num += 1;
  });
}


var PasstoFront = function(){
  $('#board').on('click', '.post-it', function () {
      console.log('ya estoy en el id de cada post')
      $(this).css('z-index', 2);
      $(this).siblings('div').css('z-index', 1);
  });
}

var StopCreating = function(){
  $('#board').on('dblclick', '.post-it', function(event){
      event.stopPropagation();
  });
}

var DeletePost = function(e){
  $('#board').on('click', 'a', function(){
    parent = this.parentElement.parentElement
    parent.remove();
  });
}

