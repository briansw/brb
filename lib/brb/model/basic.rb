module Brb
  module Model
    module Basic
      extend ActiveSupport::Concern

      included do
        include Concerns::Adminable
        include Concerns::CRUDTable
        include Concerns::Sluggable
        include Concerns::Positionable
      end
      
      module ClassMethods
        def to_title
          self.name.titleize
        end
      end
    end
  end
end