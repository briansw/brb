require "rails"

require "brb/engine"
require "brb/rails/routes"

require "carrierwave"
require "kaminari"
require "pundit"
require "inherited_resources"
require "acts-as-taggable-on"
require "redcarpet"

require "jquery-rails"
require "jquery-ui-rails"
require "jquery-fileupload-rails"
require "select2-rails"
require "selectize-rails"
require "sass-rails"

module Brb
  mattr_accessor :adminable_routes do
    []
  end
end