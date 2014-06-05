module Concerns::ElasticSearchable
  extend ActiveSupport::Concern
  
  included do
    include Elasticsearch::Model
	  include Elasticsearch::Model::Callbacks
    
    cattr_accessor :search_fields do
      Hash.new only: []
    end
    
    def self.searches(*args)
      options = args.extract_options!
      options.reverse_merge! fuzzy: false
      
      json_options = {
        only: args,
        methods: Array.wrap(options.delete(:methods)),
        include: Array.wrap(options.delete(:include))
      }
      
      @@search_options = options
      self.search_fields = json_options
    end
    
    def self.search(term)
      if term.present?
        __elasticsearch__.search(query: generate_query(term)).records
      else
        where([])
      end
    end
    
    def self.generate_query(term)
      query = {bool: {should: []}}
      
      [:only, :methods].each do |opt|
        next unless self.search_fields[opt]
        self.search_fields[opt].each do |field|
          if @@search_options[:fuzzy]
            term.split.each do |word|
              query[:bool][:should] << fuzzy_query(field, word)
            end
          end
          query[:bool][:should] << prefix_query(field, term)
        end
      end
      
      query[:bool][:should] << match_query('_all', term)
      
      query
    end
    
    def self.fuzzy_query(field, term)
      {
        fuzzy: {
          field => {
            value: term
          }
        }
      }
    end
    
    def self.match_query(field, term)
      {
        match: {
          field => term
        }
      }
    end
    
    def self.prefix_query(field, term)
      {
        prefix: { field => term }
      }
    end
    
  end
  
  def as_indexed_json(options = {})
    as_json self.class.search_fields
  end
  
end
