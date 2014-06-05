module Concerns::HasImage
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    def has_image(name = :image)
      has_one name, *image_relationship_arguments(name)
      setup_has_image_relationship name
    end
    
    def has_images(name = :images)
      has_many name, *image_relationship_arguments(name)
      setup_has_image_relationship name, multiple: true
    end
    
    def validates_presence_of_image(*attr_names)
      validates_with ImageValidator, _merge_attributes(attr_names)
    end
    
    private
    
    def image_relationship_arguments(name)
      [
        -> { where relationship_name: name }, 
        {class_name: "Image", as: :parent, dependent: :destroy}
      ]
    end
    
    def setup_has_image_relationship(name, options = {})
      accepts_nested_attributes_for name, allow_destroy: true
      
      define_method "#{name}_attributes=" do |attributes|
        if options[:multiple]
          attributes.each do |_, record| 
            record[:relationship_name] = name
            add_to_images_if_id_present(record, name)
          end
        else
          attributes[:relationship_name] = name
          add_image_if_id_present(attributes, name)
        end
        
        super attributes
      end
    end
    
  end
  
  class ImageValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value && value.attachment.present?
        record.errors[attribute] << 'needs to be uploaded'
      end
    end
  end
  
  private
  
  def add_image_if_id_present(attributes, name)
    image = send(name)
    if !attributes['id'].blank? && (!image || image.id.to_s != attributes['id'])
      self.send "#{name}=", Image.where(id: attributes['id']).first
    end
  end
  
  def add_to_images_if_id_present(attributes, name)
    images = send(name)
    if !attributes['id'].blank? && !images.collect(&:id).include?(attributes['id'].to_i)
      images << Image.where(id: attributes['id']).first
    end
  end
  
end
