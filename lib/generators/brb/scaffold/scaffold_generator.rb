class Brb::ScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  check_class_collision suffix: 'Controller'
  check_class_collision suffix: 'Policy'

  def create_migration

  end

  def create_admin_controller
    # template 'controller.rb', File.join('app/controllers/admin', "#{file_name}_controller.rb")
  end

  def create_model

  end

  def create_policy
    template 'policy.rb', File.join('app/policies', "#{file_name}_policy.rb")
  end

  def add_admin_route
    route "admin_for :#{file_name.pluralize}"
  end

end
