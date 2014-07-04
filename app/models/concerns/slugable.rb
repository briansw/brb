module Concerns::Slugable
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug

    def generate_slug
      if self.respond_to?('sluggable_field')
        self.slug = self.sluggable_field.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').parameterize.gsub('_', '')
      end
    end

    def self.from_param(param)
      find_by_slug!(param)
    end

    def to_param
      slug
    end
  end

end