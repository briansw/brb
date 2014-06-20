module Brb
  class Engine < ::Rails::Engine
    
    config.generators do |g|
      g.test_framework :test_unit, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
    
    config.to_prepare do
      Brb.adminable_routes = []
    end
    
  end
end
