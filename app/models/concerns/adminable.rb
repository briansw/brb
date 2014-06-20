module Concerns::Adminable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :adminable_options do
      []
    end
  end

  module ClassMethods
    def is_adminable
      options = {}
      options[:title] = self.pluralized_path(self.to_s)
      options[:path] = ''
      self.adminable_options = options
    end

    def pluralized_path(klass)
      if klass.pluralize != klass and klass.singularize == klass
        klass.underscore.pluralize
      else
        klass.underscore.pluralize + '_index'
      end
    end
  end

end