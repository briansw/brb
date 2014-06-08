module Concerns::CRUDTable
  extend ActiveSupport::Concern
  
  included do
    cattr_accessor :crud_headings do
      []
    end
    
    scope :active, -> { where(active: true) }
  end
  
  module ClassMethods
    def filter_crud_table(sort, direction, page, assoc_column)
      if sort && direction && heading_exists?(sort)
        sort = sort.downcase
        direction = direction.to_sym
        direction = :asc unless direction == :asc || direction == :desc
        if assoc_column
          page(page).filter_with_assoc(sort, direction, assoc_column)
        else
          page(page).filter_without_assoc(sort, direction)
        end
      else
        sort = default_heading.link + ' ASC'
        page(page).order(sort)
      end
    end
    alias_method :filter_table, :filter_crud_table
    
    def default_heading
      crud_headings.find(&:default) || crud_headings.first
    end
    
    def heading_exists?(sort)
      crud_headings.any? do |heading| 
        heading.link == sort
      end
    end
    
    def filter_with_assoc(sort, direction, assoc_column)
      order = "#{sort.pluralize}.#{assoc_column} #{direction}"
      includes(sort.to_sym).order(order)
    end

    def filter_without_assoc(sort, direction)
      order(sort => direction)
    end

    def has_heading(*args)
      options = args.extract_options!
      options[:parent] = self
      self.crud_headings << Heading.new(*args, options)
    end
    
  end
  
  class Heading
    attr_accessor :title, :link, :default, :parent, :assoc_column, 
      :helper, :display

    def initialize(*args)
      options = args.extract_options!
      options.reverse_merge! default: false
      
      @title = args.shift
      @link = options[:link]
      @default = options[:default]
      @parent = options[:parent]
      @assoc_column = options[:assoc_column]
      @helper = options[:helper]
      @display = options[:display]
    end
  end
  
end
