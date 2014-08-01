module Concerns::Sluggable
  extend ActiveSupport::Concern

  module ClassMethods
    
    def slugable(name)
      before_save :generate_slug

      class_eval <<-CODE, __FILE__, __LINE__ + 1
        def generate_slug
          self.slug = self.#{name}.mb_chars.normalize(:kd)
            .gsub(/[^\x00-\x7F]/n,'').parameterize.gsub('_', '')
        end

        def self.from_param(param)
          find_by_slug!(param)
        end

        def to_param
          #{name}
        end
      CODE
    end
    
  end

end