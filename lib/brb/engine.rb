module Brb
  class Engine < ::Rails::Engine
    
    config.generators do |g|
      g.test_framework :rspec, 
        fixture:          false,
        view_specs:       false,
        helper_specs:     false,
        routing_specs:    false,
        controller_specs: true,
        request_specs:    false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
    
  end
end
