$(document).ready(function(){
   // Create the pile of shuffled cards
   sum = 0
   space = 0
  for ( var i=0; i<10; i++ ) {
    card = new Card(i);
    $('#cardPile').append(card.attribute);
  }

  $('#cardPile div').draggable({
      // cursor: 'move',
      helper: 'clone',
      // revert: true
    });


  $('#cardSlots').droppable({
    // accept: '#cardPile div',
    drop: function( event, ui ) {
      if (space < 10){
      var value = ui.draggable.attr('value');
      var cloneNumber = ui.draggable.clone();
      $(this).append(cloneNumber);

      

      sum = sum + parseInt(value);
      space += 1;
      $('#total_sum').text(sum);
    }
  }
  });

});

// cardPile


function Card(number){
  
  this.number = number;

  this.attribute = '<div value="' + number + '">' + number + '</div>';

}

function CardPile(){

}