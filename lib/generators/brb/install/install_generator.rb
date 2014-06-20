class Brb::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  
  def create_image_uploader
    generate "uploader", "Image"
    gsub_file "app/uploaders/image_uploader.rb", 
      "CarrierWave::Uploader::Base",
      "Admin::AttachmentUploader"
  end
end
