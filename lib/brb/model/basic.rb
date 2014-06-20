module Brb
  module Model
    module Basic
      extend ActiveSupport::Concern

      included do
        include Concerns::Adminable
        include Concerns::CRUDTable
      end
    end
  end
end