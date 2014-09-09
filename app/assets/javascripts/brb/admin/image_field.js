$(function(){
  
  $('.images-field, .image-field').on('click', '.delete', function(e){
    e.preventDefault();
    $(this).parents('.image').toggleDestroy();
  })
  
});

$.fn.extend({
  toggleDestroy: function(){
    var $this = $(this);
    var $input = $this.find('input.destroy');
    var value = $input.val();
    
    $this.toggleClass('will-destroy');
    $input.val(value === "true" ? "false" : "true");
  }
});