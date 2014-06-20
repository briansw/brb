module Concerns::HasContentBlocks
  extend ActiveSupport::Concern
  
  module ClassMethods
    def has_content_block(name)
      cattr_accessor :available_content_blocks do
        [name.to_s.classify]
      end
      
      has_many :content_blocks, -> { order(position: :asc, created_at: :asc) }, as: :parent, dependent: :destroy
      accepts_nested_attributes_for :content_blocks, allow_destroy: true
      
      class_eval <<-CODE
        def self.has_content_block(name)
          self.available_content_blocks << name.to_s.classify
        end
      CODE
    end
    
    def has_content_blocks(*names)
      names.each do |name|
        has_content_block name
      end
    end
  end
  
end
