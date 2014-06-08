module Concerns::HasContentBlocks
  extend ActiveSupport::Concern
  
  included do
    has_many :content_blocks, -> { order(position: :asc, created_at: :asc) }, as: :parent, dependent: :destroy
    accepts_nested_attributes_for :content_blocks, allow_destroy: true

    cattr_accessor :available_content_blocks do
      []
    end
  end


  module ClassMethods
    def has_content_block(name)
      self.available_content_blocks << name
    end
  end
  
end
