module Admin::ApplicationHelper
  
  def admin_edit_link(resource)
    return unless current_user && current_user.active?
    path = polymorphic_path([:admin, resource.class.name.downcase], id: resource.id, action: :edit)
    html_options = {
      class: 'admin-edit-link', 
      target: '_blank',
      data: {
        no_turbolink: true
      }
    }
    link_to "Edit", path, html_options
  end
  
  def display_notice(notice, alert)
    if notice
      content_tag(:div, notice, class: 'notice message')
    else
      content_tag(:div, alert, class: 'notice error')
    end
  end

  def display_dropdown_selected(name)
    name.titleize
  end

  def display_dropdown_item(name, url)
    class_to_use = controller_name.titleize == name ? 'selected' : 'link'
    link_to(name, url, class: class_to_use)
  end

  def display_boolean_marker(active)
    status = active ? 'active' : 'inactive'
    content_tag(:div, status, class: "active-marker #{status}")
  end

  def display_crud_headings_for(klass, options = {})
    klass_name = klass.name.to_sym
    crud_headings = klass.crud_headings
    options[:target] ||= "##{klass_name.to_s.pluralize}-crud-table"
    
    crud_headings.collect do |crud_heading|
      classes = crud_heading_class(crud_heading)
      data_attributes = crud_heading_attributes(crud_heading)
      title = crud_heading_title(crud_heading).html_safe
      url = collection_path(klass, params: data_attributes)
      
      content_tag :th do
        link_to title, url, class: classes, remote: true
      end
    end.join('').html_safe
  end
  
  def display_record_column(heading, *args)
    options = args.extract_options!
    return '' unless options[:for] && options[:for].is_a?(ActiveRecord::Base)
    
    column = options[:for].column_for_attribute(heading.link)
    value = heading.display(options[:for])
    
    return value unless column
    
    case column.type
    when :boolean
      display_boolean_marker value
    else
      value
    end
  end

  def crud_heading_class(heading)
    if heading_selected?(heading) || show_default_heading?(heading)
      'selected sorter'
    else
      'sorter'
    end
  end

  def crud_heading_attributes(heading)
    klass = heading.parent
    next_direction = sort_direction_cycle('desc', 'asc')
    
    if heading_selected?(heading)
      direction = next_direction
    elsif show_default_heading?(heading)
      direction = 'desc'
    else
      direction = 'asc'
    end
    
    attributes = {
      direction: direction,
      page: params[:page] || 1,
      sort: heading.link,
      assoc_column: heading.assoc_column
    }
    
    attributes[:query] = params[:query] if params[:query]
    attributes
  end

  def crud_heading_title(heading)
    if heading_selected?(heading) || show_default_heading?(heading)
      heading.title + sort_direction_cycle(' &#9660;', ' &#9650;')
    else
      heading.title
    end
  end
  
  def sort_direction_cycle(asc = '', desc = '')
    direction = (params[:direction] || '').downcase
    
    if direction == 'asc' 
      asc
    elsif direction == 'desc'
      desc
    else
      asc
    end
  end
  
  def heading_selected?(heading)
    params[:sort].present? && params[:sort] == heading.link
  end
  
  def show_default_heading?(heading)
    params[:sort].nil? && heading.default
  end
  
  def link_to_new
    link_to("New #{resource_instance_name.to_s.titleize}", new_resource_path, class: 'large-button action') if policy(resource_class).new?
  end
  
  def link_to_delete(model)
    link_to(raw('&#10008;'), resource_path(model), data: { confirm: 'Are you sure?' }, method: :delete, class: 'delete') if policy(model).destroy?
  end
  
  def link_to_edit(model)
    link_to(raw('&#9998;'), edit_resource_path(model), class: 'edit reverse') if policy(model).edit?
  end

  def errors_for(model)
    if model.errors.any?
      content_tag(:div, class: "notice error") do
        notice = t('admin.resource.has_errors', count: model.errors.count)
        list = content_tag(:ul) do
          model.errors.full_messages.map do |msg|
            content_tag(:li, msg)
          end.join.html_safe
        end
        (notice + list).html_safe
      end
    end
  end
  
  def collection_search_form
    return unless resource_class.respond_to? :search
    content_tag :form, action: collection_path, method: 'GET', id: 'search-form' do
      tag :input, type: 'text', name: 'query', value: params[:query]
    end
  end

  #######################
  ### Content Block #####
  #######################
  # Let's make a content_block_helper

  def delete_content_block(name, div_wrapper_id, existing)
    data = { confirm: 'Are you sure?', content_block: "#content-block-#{div_wrapper_id}-wrapper" }
    data[:destroy_field] = "#destroy-#{div_wrapper_id}" if existing
    link_to(name, '#', data: data, class: 'small-button delete delete-content-block')
  end

  def delete_slide(name, div_wrapper_id, existing)
    data = { confirm: 'Are you sure?', content_block: "#content-block-#{div_wrapper_id}-wrapper" }
    data[:destroy_field] = "#destroy-#{div_wrapper_id}" if existing
    link_to(name.html_safe, '#', data: data, class: 'delete-slide delete-content-block')
  end

end