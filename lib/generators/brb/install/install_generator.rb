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

  def create_user_model
    generate 'model', 'User --skip-migration'
    migration_template 'create_users_migration.rb', 'db/migrate/create_users.rb'
  end

  def create_image_model
    generate 'model', 'Image --skip-migration'
    migration_template 'create_images_migration.rb', 'db/migrate/create_images.rb'
  end

  def create_image_uploader
    template 'image_uploader.rb', 'app/uploaders/image_uploader.rb'
  end
end
