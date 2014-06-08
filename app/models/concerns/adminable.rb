module Concerns::Adminable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :adminable_options do
      []
    end
  end

  module ClassMethods
    def adminable(*args)
      options = args.extract_options!
      options[:title] = self.to_s.pluralize.titleize
      options[:path] = ''
      self.adminable_options = options
    end
  end

end