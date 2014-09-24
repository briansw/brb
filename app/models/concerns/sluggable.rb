module Concerns::Sluggable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :sluggable_options do
      []
    end
  end

  module ClassMethods

    def sluggable(*fields)
      fields.each { |f|  self.sluggable_options << f }
      before_save :generate_slug

      class_eval <<-CODE, __FILE__, __LINE__ + 1

        def generate_slug
          sluggable_options.collect! do |field|
            slugify(field)
          end

          self.slug = sluggable_options.collect{ |f| f.present? }.first

        end

        def slugify(field)

puts field
puts self.send(field).present?

          if self.respond_to?(field) && self.send(field).present?
            self.send(field).mb_chars.normalize(:kd)
            .gsub(/[^\x00-\x7F]/n,'').parameterize.gsub('_', '')
          end
        end

        def self.from_param(param)
          find_by_slug!(param)
        end

        def to_param
          self.slug
        end
      CODE
    end
    
  end

end