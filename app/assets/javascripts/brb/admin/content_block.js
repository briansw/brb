$(function(){
  
  setTextAreas();
  updateSequence();
  
  $('#content-blocks').sortable({
      axis: 'y',
      items: '.content-block-wrapper',
      handle: '> .content-block > .actions-wrapper',
      containment: '#content-blocks',
      stop: function(event, ui) {
          ui.item.wasMoved();
          setTextAreas();
          updateSequence();
      }
  });
  
  $('.slides').sortableSlides();
  $('.images-field .images').sortableImages();

  $(document).on('click', '.delete-content-block', function(event) {
      event.preventDefault();

      var content_block = $(this).data('content-block'),
          destroy_field = $(this).data('destroy-field');
        
      if (typeof destroy_field === "undefined") {
          if (content_block === "#content-block-slide-wrapper") {
              content_block = $(this).parents('.slide');
          }
          $(content_block).slideToggle(function() {
              $(content_block).remove();
          });
      } else {
          if (destroy_field === '#destroy-slide') {
              content_block = $(this).parents('.slide');
              destroy_field = content_block.find('input.destroy');
          }
          $(destroy_field).val(1);
          $(content_block).slideToggle(function() {
              $(content_block).insertAfter('#content-blocks');
          });
      }
  });

  $(document).on('click', '.new-content-block', function(event) {
      event.preventDefault();
      
      var id         = $(this).data('id'),
          fields     = $(this).data('fields'),
          type       = $(this).data('type'),
          regexp     = new RegExp($(this).data('id'), 'g'),
          time       = new Date().getTime(),
          cb         = '#content-block-' + time,
          cb_wrapper = $(this).closest('.content-block-wrapper'),
          options    = $('#cloneable-cb-options').clone().removeAttr('id');
          
      $(fields.replace(regexp, time)).insertBefore(cb_wrapper);
      $('#placeholder-options').replaceWith(options);
      setTextAreas();
      updateSequence();
      $(cb).slideToggle()
        .sortableSlides()
        .scrollToUnlessVisible()
        .setupUploader();
  });
  
  $(document).on('click', '.new-slideshow-slide', function(event) {
      event.preventDefault();
      
      var id         = $(this).data('id'),
          fields     = $(this).data('fields'),
          type       = $(this).data('type'),
          regexp     = new RegExp($(this).data('id'), 'g'),
          time       = new Date().getTime(),
          cb         = '#content-block-' + time,
          wrapper    = $(this).siblings('.slides');
    
      var $slide = $(fields.replace(regexp, time));
      wrapper.append($slide);
      setTextAreas();
      updateSequence();
      $slide.slideDown()
        .scrollToUnlessVisible()
        .setupUploader();
  });

  $(document).on('click', '.move-block', function(event) {
      event.preventDefault();
      
      if (typeof $(this).data('target') === "undefined") {
          var content_block = $(this).parents('.slide'),
              all_content_blocks = content_block.siblings('.slide').add(content_block);
      } else {
          var all_content_blocks = $('.content-block-wrapper').not('.base-block'),
              content_block    = $(this).data('target');
      };
      
      var direction        = parseInt($(this).data('direction')),
          current_position = $(all_content_blocks).index($(content_block)),
          next_position    = current_position + direction,
          swap_with        = $(all_content_blocks).eq(next_position),
          sortable         = swap_with.length > 0 && next_position >= 0 ? true : false,
          $block           = $(content_block);

      if (sortable) {
          $block.hide();
          if (direction == 1) {
            $block.insertAfter(swap_with);
          } else {  
            $block.insertBefore(swap_with);
          }
          $block.wasMoved().fadeIn(600);
          setTextAreas();
          updateSequence();
      }
  });
  
  $('#submit-with-content-blocks input[type="submit"]').bind('click', function(event) {
      event.stopPropagation();
      $('#void').addClass('saving').toggleClass('hide').append('<p>Saving ...</p>');
  });

  $('.content-block').setupUploader();
  
});

function updateSequence() {
  $('.content-block > .content > .position').each(function(x) {
    $(this).val(x + 1);
  });

  $('.slides .position').each(function(x) {
    $(this).val(x + 1);
  });

  $('.images-field .images .image .position').each(function(x) {
    $(this).val(x + 1);
  });
}

function setTextAreas() {
    $('.textarea').each(function(x) {
        var $this = $(this);
        
        if (typeof $this.data('editor') == "undefined") {
            $this.createRichTextArea();
        }
    });
}
