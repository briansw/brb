module Concerns::GenerateSlug
  extend ActiveSupport::Concern

  included do
    before_save :generate_slug

    def generate_slug
      # Replace accent marks with a-z, strip out spaces and special characters
      self.slug = string_to_convert.mb_chars.normalize(:kd).gsub(/[^\x00-\x7F]/n,'').parameterize.gsub('_', '')
    end
  end

  private
    def string_to_convert
      if self.respond_to?('full_name')
        "#{set_first_name}#{middle_and_last_name}"
      elsif self.respond_to?('title')
        self.title
      elsif self.respond_to?('name')
        self.name
      else
        self.errors[:base] << 'Slug Generator does not recognize the string you are trying to convert.'
        ''
      end
    end

end