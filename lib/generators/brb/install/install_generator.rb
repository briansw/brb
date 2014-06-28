class Brb::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  include Rails::Generators::Migration
  require 'rails/generators/active_record'

  def self.next_migration_number(*args)
    ActiveRecord::Generators::Base.next_migration_number(*args)
  end

  def create_seeds
    File.delete('db/seeds.rb') if File.exist?('db/seeds.rb')
    template 'seeds.rb', 'db/seeds.rb'
  end

  def create_permit_params_concern
    template 'controllers/concerns/permit_params.rb', 'app/controllers/concerns/permit_params.rb'
  end

  def create_users_resource
    template 'controllers/user.rb', 'app/controllers/admin/users_controller.rb'
    template 'models/user.rb', 'app/models/user.rb'
    template 'policies/user_policy.rb', 'app/policies/user_policy.rb'
    template 'views/admin/users/_form.html.erb', 'app/views/admin/users/_form.html.erb'
    migration_template 'migrations/user.rb', 'db/migrate/create_users.rb'
  end

  def create_images_resource
    migration_template 'migrations/image.rb', 'db/migrate/create_images.rb'
  end

  def create_image_uploader
    template 'uploaders/image_uploader.rb', 'app/uploaders/image_uploader.rb'
  end

  def create_content_blocks_migration
    migration_template 'migrations/content_block.rb', 'db/migrate/create_content_blocks.rb'
  end

  def create_text_block
    template 'models/text_block.rb', 'app/models/text_block.rb'
    template 'views/admin/content_blocks/text_block/_form.html.erb', 'app/views/admin/content_blocks/text_block/_form.html.erb'
    template 'views/content_blocks/text_block/_show.html.erb', 'app/views/content_blocks/text_block/_show.html.erb'
    migration_template 'migrations/text_block.rb', 'db/migrate/create_text_blocks.rb'
  end

  def create_image_block
    template 'models/image_block.rb', 'app/models/image_block.rb'
    template 'views/admin/content_blocks/image_block/_form.html.erb', 'app/views/admin/content_blocks/image_block/_form.html.erb'
    template 'views/content_blocks/image_block/_show.html.erb', 'app/views/content_blocks/image_block/_show.html.erb'
    migration_template 'migrations/image_block.rb', 'db/migrate/create_image_blocks.rb'
  end

  def create_slideshow_block
    template 'models/slideshow_block.rb', 'app/models/slideshow_block.rb'
    template 'models/slide.rb', 'app/models/slide.rb'
    template 'views/admin/content_blocks/slideshow_block/_form.html.erb', 'app/views/admin/content_blocks/slideshow_block/_form.html.erb'
    template 'views/admin/content_blocks/slideshow_block/_slide.html.erb', 'app/views/admin/content_blocks/slideshow_block/_slide.html.erb'
    template 'views/content_blocks/slideshow_block/_show.html.erb', 'app/views/content_blocks/slideshow_block/_show.html.erb'
    migration_template 'migrations/slideshow_block.rb', 'db/migrate/create_slideshow_blocks.rb'
    migration_template 'migrations/slide.rb', 'db/migrate/create_slides.rb'
  end

  def create_video_block
    template 'models/video_block.rb', 'app/models/video_block.rb'
    template 'views/admin/content_blocks/video_block/_form.html.erb', 'app/views/admin/content_blocks/video_block/_form.html.erb'
    template 'views/content_blocks/video_block/_show.html.erb', 'app/views/content_blocks/video_block/_show.html.erb'
    migration_template 'migrations/video_block.rb', 'db/migrate/create_video_blocks.rb'
  end

end
