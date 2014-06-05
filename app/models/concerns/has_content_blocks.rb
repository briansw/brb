module Concerns::HasContentBlocks
  extend ActiveSupport::Concern
  
  included do
    has_many :content_blocks, -> { order(position: :asc, created_at: :asc) }, as: :parent, dependent: :destroy
    accepts_nested_attributes_for :content_blocks, allow_destroy: true
  end
  
end
