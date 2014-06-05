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
      true_heading = crud_headings.any? do |crud_heading| 
        crud_heading.link == sort
      end

      if sort && direction && true_heading
        if assoc_column
          filter_with_assoc(sort, direction, page, assoc_column)
        else
          filter_without_assoc(sort, direction, page)
        end
      else
        sort = crud_headings.select do |crud_heading| 
          crud_heading.default
        end.first.link + ' ASC'
        page(page).order(sort)
      end
    end
    alias_method :filter_table, :filter_crud_table

    def filter_with_assoc(sort, direction, page, assoc_column)
      sort = sort.downcase
      direction = direction.upcase
      direction = 'ASC' unless direction == 'ASC' || direction == 'DESC'
      order = sort.pluralize + '.' + assoc_column + ' ' + direction
      page(page).includes(sort.to_sym).order(order)
    end

    def filter_without_assoc(sort, direction, page)
      sort = sort.downcase
      direction = direction.upcase
      direction = 'ASC' unless direction == 'ASC' || direction == 'DESC'
      sort += ' ' + direction
      page(page).order(sort)
    end

    def has_heading(*args)
      options = args.extract_options!
      options[:parent] = self
      self.crud_headings << Heading.new(*args, options)
    end
    
  end
  
  class Heading
    attr_accessor :title, :link, :default, :parent, :assoc_column

    def initialize(*args)
      options = args.extract_options!
      @title = args.shift
      @link = options[:link]
      @default = options[:default] || false
      @parent = options[:parent]
      @display = options[:display]
      @assoc_column = options[:assoc_column]
    end

    def display(record)
      @display.present? ? record.send(@display) : record.send(@link)
    end
  end
  
end