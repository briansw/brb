// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.sortable
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require select2
//= require selectize
//= require brb/admin/wysihtml5/wysihtml5-0.4.0pre.min.js
//= require_tree ./admin

$(function(){
  
    $(document).on('click', '.notice', function() {
        $(this).fadeOut();
    });
    
    $(document).on('click', '.dropdown-selected', (function() {
        $('#void').toggleClass('hide');
        $(this).parent().toggleClass('active-dropdown');
        $(this).next().toggle();
    }));
    
    $(document).on('click', '#void', function() {
        if (!$(this).hasClass('saving')) {
            $(this).toggleClass('hide');
            $('.dropdown-selected').next().toggle();
        }
    });
    
    $('.select2').select2({
        width: 400
    });
    
    $('.tag-input').each(function(i, field){
        var $field = $(field),
            autoloadPath = $field.data('autoload-path');
            
        $field.selectize({
            plugins: ['remove_button'],
            create: true,
            valueField: 'name',
            labelField: 'name',
            searchField: 'name',
            load: function(query, callback) {
                if (!query.length) return callback();
                $.ajax({
                    url: autoloadPath + "&query=" + encodeURIComponent(query),
                    type: 'GET',
                    error: function() {
                        callback();
                    },
                    success: function(res) {
                        callback(res.slice(0, 10));
                    }
                });
            }
        });
    });

    $('.relation-input').each(function(i, field){
        var $field = $(field),
            autoloadPath = $field.data('autoload-path'),
            labelField = $field.data('label-field'),
            data = $field.data('preload'),
            value = $field.val().split(/,\s?/),
            $select;
        
        $select = $field.selectize({
            plugins: ['remove_button'],
            create: false,
            valueField: 'id',
            labelField: labelField,
            searchField: labelField,
            options: data,
            load: function(query, callback) {
                if (!query.length) return callback();
                $.ajax({
                    url: autoloadPath + "?query=" + encodeURIComponent(query),
                    type: 'GET',
                    error: function() {
                        callback();
                    },
                    success: function(res) {
                        callback(res.slice(0, 10));
                    }
                });
            }
        });
        
        // This is a bit of a hack to set the value of the field properly
        $select.get(0).selectize.setValue(value);
    });
    
    $('.image-field, .images-field').setupUploader()
});

jQuery.fn.extend({
    wasMoved: function() {
        if ($(this).hasClass('textarea')) {
            $(this).createRichTextArea();
        } else {
            $(this).find('.textarea').createRichTextArea();
        };
        return $(this);
    },
    
    scrollToUnlessVisible: function() {
        var position = $(this).offset().top,
            positionOffset = 10,
            limitOffset = 200,
            limit = $(window).scrollTop() + $(window).height() - limitOffset;
    
        if (position > limit) {
            $('body, html').animate({
                scrollTop: position - positionOffset
            });
        }
        return $(this);
    },
    
    setupUploader: function() {
        var $this = $(this),
            $inputs = $(this).find('input:file');
            
        $inputs.each(function(i, input){
            var $input = $(input),
                $field = $input.parents('.image-field, .images-field'),
                $image = $field.find('img'),
                multiple = typeof $input.data('multiple') !== 'undefined',
                progressTemplate = $field.find('.progress-template').text();
            
            var addFile = function(e, data) {
                data.context = $(tmpl(progressTemplate, data.files[0]));
                data.context.prependTo($field);
                if (!multiple) {
                    $image.hide();
                }
                data.submit();
            }
            
            var uploadProgress = function(e, data) {
                $('input[type="submit"]').attr('disabled','disabled');

                var progress = parseInt(data.loaded / data.total * 100);
                $(data.context).find('.bar').css('width', progress + '%');
            }
            
            var uploadDone = function(e, data) {
                $('input[type="submit"]').removeAttr('disabled');
                
                $(data.context).fadeOut(1000);
                
                if (multiple) {
                    var t = $input.data('template');
                    var id = $input.data('replacement-id');
                    var $newImage = $(t.replace(new RegExp(id, 'g'), new Date().getTime()));
                    $newImage.find('img').attr('src', data.result.attachment.admin_thumb.url);
                    $newImage.find('.image-id').val(data.result.id);
                    $field.find('.images').append($newImage);
                } else {
                    if (!$image.length) {
                        $image = $('<img>').prependTo($field);
                    }

                    $image.attr('src', data.result.attachment.admin_thumb.url).show();
                    $field.find('.image-id').val(data.result.id);
                };
            }
            
            var uploadError = function(e, data) {
                console.log('upload error', data);
            }
            
            $input.fileupload({
                dropZone: $field,
                formData: [],
                paramName: 'image[attachment]',
                add: addFile,
                progress: uploadProgress,
                done: uploadDone,
                error: uploadError
            }); 
        });
        
        if (typeof window.preventDefault == "undefined") {
            window.preventDefault = function(e) { e.preventDefault(); };
            $(document).bind('drop dragover', window.preventDefault);
        }
        return $this;
    },
    
    sortableSlides: function(){
        $(this).sortable({
            axis: 'y',
            items: '.slide',
            handle: '> .actions-wrapper',
            containment: 'parent',
            stop: function(event, ui) {
                ui.item.wasMoved();
                setTextAreas();
            }
        });
        return $(this);
    },
    
    createRichTextArea: function() {
        $(this).each(function(i, editor){
            var $this = $(this);
            var $field = $this.parents('.field');
            var $form = $this.parents('form');

            $this.removeData('editor');
            $field.find('.wysihtml5-sandbox, input:hidden[name=_wysihtml5_mode]').remove();

            var textarea = $this,
                toolbar  = $this.parents('.field').find('.textarea-toolbar');
            
            $this.css('display', 'block');

            var editor = new wysihtml5.Editor(textarea.uniqueId().attr('id'), {
                toolbar:       toolbar.uniqueId().attr('id'),
                parserRules:   wysihtml5ParserRules,
                useLineBreaks: false,
                autoLink:      true,
                cleanUp:       true
            });
            
            editor.formatValue = function(){
                value = this.getValue();
                this.setValue(value.replace(/<p>\s*<br\/?>\s*<\/p>/g, ''));
            }

            editor.on("load", function(){
                $(this.composer.iframe).wysihtml5_size_matters();
                this.formatValue();
            });
            
            editor.on("blur", function(){
                setTimeout(function(){
                  if ($field.find('.link-field').is(':visible')) return;
                  this.formatValue();
                }.bind(this), 100)
            });
            
            editor.on("focus", function(){
                setTimeout(function(){
                  this.formatValue();
                }.bind(this), 100)
            });
            
            $form.on("submit", function(){
                editor.formatValue();
            });

            $this.data('editor', editor);
        })
    }
});
