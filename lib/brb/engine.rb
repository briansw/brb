module Brb
  class Engine < ::Rails::Engine
    
    cattr_accessor :adminable_routes do
      []
    end
    
    config.generators do |g|
      g.test_framework :test_unit, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
    
    config.to_prepare do
      Brb::Engine.adminable_routes = []     
    end
    
    initializer "brb.setup_root_route", after: "finisher_hook" do |app|
      app.reload_routes!
      if !app.routes.routes.any? {|r| r.name == 'admin_root'} && 
          Brb::Engine.adminable_routes.any?
        Rails.application.routes.draw do
          namespace :admin do
            root to: "#{Brb::Engine.adminable_routes.first}#index"
          end
        end
      end
    end
    
    def self.admin_classes
      self.adminable_routes.map do |model|
        model.to_s.singularize.camelize.constantize
      end
    end
    
  end
end
