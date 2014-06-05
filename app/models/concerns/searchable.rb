require 'set'

module Concerns::Searchable
  extend ActiveSupport::Concern
  
  included do
    
    cattr_accessor :search_fields do
      Set.new
    end
    
    def self.searches(*fields)
      self.search_fields.merge fields 
    end
    
    def self.search(query)
      if query.present? && search_fields.any?
        table = arel_table
        conditions = search_fields.map do |field|
          table[field].matches("%#{query}%")
        end
        where(conditions.inject(&:or))
      else
        where([])
      end
    end
    
  end
  
end
