module Concerns::Adminable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :adminable_options do
      []
    end
  end

  module ClassMethods
    def is_adminable(options = {})
      self.adminable_options = options
    end
    
    def to_title
      self.name.titleize
    end
  end

end