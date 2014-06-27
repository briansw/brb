module ActionDispatch::Routing
  class Mapper
    # Includes admin_for method for routes. This method sets up
    # the correct namespaced admin routes and routing concerns based
    # on the resource in question.
    #
    # ==== Examples
    #
    #   admin_resources :ducks
    #
    def admin_for(*resources)
      options = resources.extract_options!
      options.reverse_merge! private: false
      resources.map!(&:to_sym)
      
      resources.each do |resource|
        Brb::Engine.adminable_routes << resource unless options[:private]
        namespace :admin do
          self.resources(resource) do
            # TODO: Only load this when a model has the taggable concern
            collection do
              get :tags
            end
          end
        end
      end
    end
    
  end
end
