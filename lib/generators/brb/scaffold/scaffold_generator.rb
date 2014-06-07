class Brb::ScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  def add_admin_route
    route "admin_for :#{file_name.pluralize}"
  end
end
