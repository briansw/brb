class Admin::FormBuilder < ActionView::Helpers::FormBuilder
  
  def content_block_fields(options = {})
    render 'admin/content_blocks/block_list', f: self
  end
  
  def multi_select_field(method, *args)
    options = args.extract_options!
    options.reverse_merge!({
      class: '',
      data: {}
    })
    
    options[:data][:'autoload-path'] = options.delete(:path)
    options[:class] += " multi-select-input"
    
    text_field(method, *args, options)
  end
  
  def relation_field(name, *args)
    options = args.extract_options!
    options.reverse_merge!({
      class: '',
      data: {},
      label_field: 'title'
    })
    
    label = options.delete(:label_field)
    collection = @object.send(name)
    
    options[:class] += " relation-input"
    options[:data][:'label-field'] = label
    options[:data][:preload] = collection.to_json
    options[:value] = collection.collect(&:id).join(', ')
    options[:path] = polymorphic_path([:admin, name], format: :json)
    
    multi_select_field(name, *args, options)
  end
  
  def tag_field(name, *args)
    options = args.extract_options!
    options.reverse_merge!({
      class: ''
    })
    
    list_name = "#{name.to_s.singularize}_list".to_sym
    
    options[:path] = polymorphic_path([:admin, @object.class], action: 'tags', scope: name, format: :json)
    options[:class] += " tag-input #{name}-input"
    
    multi_select_field(list_name, *args, options)
  end

  def image_field(method, *args)
    options = args.extract_options!
    options.reverse_merge!({
      progress_template: 'admin/shared/progress_template'
    })
    
    content_tag :div, class: 'image-field' do
      image = @object.send(method.to_sym) || @object.send("build_#{method}")
      uploader = fields_for(method, image) do |fields|
        attachment = fields.file_field(:attachment, data: {
          url: admin_images_path(format: :json)
        })

        content_tag(:div, class: 'image') do
          concat image_attachment(image) unless image.new_record?
          concat fields.image_destroy_field()
          concat fields.hidden_field(:attachment_cache)
          concat fields.hidden_field(:id, class: 'image-id')
        end + attachment


      end

      concat uploader
      concat render(options[:progress_template])
    end
  end
  
  def images_field(method, *args, &block)
    options = args.extract_options!
    options.reverse_merge!({
      progress_template: 'admin/shared/progress_template'
    })
    
    content_tag :div, class: 'images-field' do
      images = image_field_images(method, @object.send(method), &block)
      
      image = @object.send(method).new
      uploader = fields_for(method, [image], child_index: image.object_id) do |fields|
        
        template = content_tag :div, class: 'image' do
          concat fields.image_attachment
          concat fields.image_destroy_field
          concat fields.position_field
          concat fields.hidden_field(:id, class: 'image-id')
          concat block.call(fields).html_safe if block
        end
        
        concat fields.file_field(:attachment, data: {
          url: admin_images_path(format: :json),
          multiple: true,
          template: template.gsub(/\n/, ''),
          replacement_id: image.object_id
        })
        
      end
      
      concat images
      concat uploader
      concat render(options[:progress_template])
    end
    
  end
  
  def image_field_images(method, images, &block)
    content_tag :div, class: 'images' do
      images.map do |image|
        concat image_field_image(method, image, &block)
      end
    end
  end
  
  def image_field_image(method, image, &block)
    content_tag :div, class: 'image' do
      attribute_fields = fields_for(method, image) do |fields|
        concat(block.call(fields)) if block
        concat(fields.image_destroy_field)
        concat fields.position_field
      end
      
      concat image_attachment(image) unless image.new_record?
      concat attribute_fields
    end
  end
  
  def image_attachment(image = nil)
    image ||= @object
    if image.attachment_url && image.attachment_url.split(//).last(3).join == 'pdf'
      image_tag('brb/pdf-icon.png', width: 56, height: 57, class: 'image-attachment') +
      content_tag(:div, image.attachment_url.split('/').last, class: 'pdf-attachment')
    else
      image_tag(image.attachment_url(:admin_thumb), class: 'image-attachment')
    end
  end
  
  def image_destroy_field(options = {})
    destroy_field(options) + link_to(raw('&#10008;'), '#', class: 'delete')
  end
  
  def rich_text_area(*args)
    options = args.extract_options!
    options.reverse_merge!({
      class: '',
      toolbar: true
    })
    
    options[:class] += ' textarea'
    display_toolbar = options.delete(:toolbar)
    
    content_tag :div, class: 'rich-text-area' do
      concat toolbar if display_toolbar
      concat text_area(*args, options)
    end
  end
  
  def video_field(name, *args)
    options = args.extract_options!
    options.reverse_merge!({
      class: ''
    })
    options[:class] += ' video-field'
    text_field(name, *args, options)
  end
  
  def toolbar
    render 'admin/content_blocks/toolbar', field: self
  end
  
  def actions
    content_tag :div, class: 'withgutters', id: 'submit-with-content-blocks' do
      concat submit(data: {disable_with: 'Saving...'})
      concat cancel_link
    end
  end
  
  def cancel_link
    path = polymorphic_path([:admin, @object.class])
    link_to('Cancel', path, class: 'cancel-button')
  end
  
  def destroy_field(options = {})
    options.reverse_merge!({
      class: 'destroy',
      value: @object && @object.marked_for_destruction?, 
      id: "destroy-#{self.object_id}"
    })
    
    hidden_field :_destroy, options
  end
  
  def position_field
    hidden_field :position, class: 'position'
  end
  
  def new_slideshow_slide_button(label, options = {})
    options.reverse_merge!({
      type: :text
    })
    slide = @object.send(:slides).new slide_type: options[:type].to_s
    id = slide.object_id
    fields = fields_for :slides, slide, child_index: id do |field|
      render('admin/content_blocks/slideshow_block/slide', f: field)
    end
    link_to(label, '#', data: { id: id, type: 'Slide', fields: fields.gsub('\n', '') }, class: 'new-slideshow-slide small-button')
  end
  
  def new_content_block(name, block_type, options = {})
    options.reverse_merge! class: 'large-button'
    
    content_block = @object.send(:content_blocks).new
    id = content_block.object_id
    fields = fields_for :content_blocks, content_block do |content_block_field|
      render('admin/content_blocks/new', id: id, block_type: block_type, content_block: content_block, content_block_field: content_block_field, f: self, content_block_id: id)
    end
    
    link_to(name, '#', data: { id: id, type: block_type, fields: fields.gsub('\n', '') }, class: "new-content-block #{options[:class]}")
  end
  
  def new_content_block_buttons
    content_tag :div, class: 'content-block-buttons' do
      resource.available_content_blocks.each do |cb|
        concat new_content_block("New #{cb}", cb)
      end
    end
  end
  
  protected
  
  def concat(*args)
    @template.concat(*args)
  end
  
  def method_missing(method, *args, &block)
    if @template.respond_to?(method)
      @template.send(method, *args, &block)
    else
      super
    end
  end
  
  private
  
  def submit_default_value
    object = convert_to_model(@object)
    key    = object ? (object.persisted? ? :update : :create) : :submit

    model = if object.class.respond_to?(:to_title)
      object.class.to_title
    elsif object.class.respond_to?(:model_name)
      object.class.model_name.human
    else
      @object_name.to_s.humanize
    end

    defaults = []
    defaults << :"helpers.submit.#{object_name}.#{key}"
    defaults << :"helpers.submit.#{key}"
    defaults << "#{key.to_s.humanize} #{model}"

    I18n.t(defaults.shift, model: model, default: defaults)
  end
  
end
