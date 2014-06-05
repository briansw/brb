module Concerns::HasTags
  extend ActiveSupport::Concern
  
  module ClassMethods
    
    def has_tags(scope = :tags)
      acts_as_taggable_on scope
    end
    
  end
  
end
