$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem"s version:
require 'brb/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'brb'
  s.version     = Brb::VERSION
  s.authors     = ['Brian Watterson', 'Jack Jennings']
  s.email       = ['brian@brianwatterson.com', 'j@ckjennin.gs']
  s.homepage    = 'http://github.com/briansw/brb'
  s.summary     = 'Tiny tool for scaffolding admin interfaces in Rails'
  s.description = 'Tiny tool for scaffolding admin interfaces in Rails'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.1.2'
  s.add_dependency 'bcrypt-ruby', '~> 3.1.5'
  
  s.add_dependency 'mini_magick'
  s.add_dependency 'carrierwave'
  s.add_dependency 'kaminari'
  s.add_dependency 'pundit', '~> 0.2.2'
  s.add_dependency 'inherited_resources'
  s.add_dependency 'acts-as-taggable-on'
  s.add_dependency 'redcarpet'

  s.add_dependency 'jquery-rails'
  s.add_dependency 'jquery-ui-rails', '~> 5.0.0'
  s.add_dependency 'jquery-fileupload-rails'
  s.add_dependency 'select2-rails', '~> 3.5.4'
  s.add_dependency 'selectize-rails'
  s.add_dependency 'sass-rails', '~> 4.0.3'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'factory_girl_rails', '~> 4.2.1'
  s.add_development_dependency 'temping'

end
