class Brb::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  include Rails::Generators::Migration
  require 'rails/generators/active_record'

  def self.next_migration_number(*args)
    ActiveRecord::Generators::Base.next_migration_number(*args)
  end

  def copy_seeds
    File.delete('db/seeds.rb') if File.exist?('db/seeds.rb')
    template 'seeds.rb', 'db/seeds.rb'
  end

  def create_users_resource
    template 'models/user_model.rb', 'app/models/user.rb'
    template 'views/user_form.html.erb', 'app/views/admin/users/_form.html.erb'
    migration_template 'migrations/users_migration.rb', 'db/migrate/create_users.rb'
  end

  def create_images_resource
    template 'models/image_model.rb', 'app/models/image.rb'
    migration_template 'migrations/images_migration.rb', 'db/migrate/create_images.rb'
  end

  def create_image_uploader
    template 'uploaders/image_uploader.rb', 'app/uploaders/image_uploader.rb'
  end
end
