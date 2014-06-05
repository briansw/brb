$(function(){
  
  $(document).on('keyup', '#search-form input', function(){
    var $form = $('#search-form');
    $.get($form.attr('action'), $form.serialize(), function(){}, 'script');
  })
  
})