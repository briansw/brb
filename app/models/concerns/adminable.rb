module Concerns::Adminable
  extend ActiveSupport::Concern

  included do
    cattr_accessor :adminable_options do
      Hash.new
    end
  end

  module ClassMethods
    def is_adminable(options = {})
      self.adminable_options = options
    end
  end

end