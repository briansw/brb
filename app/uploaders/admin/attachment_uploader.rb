class Admin::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process :store_original_dimensions
  process :store_content_type

  version :admin_tiny_thumb, if: :image? do
    process :resize_to_fit => [30, 30]
  end

  version :admin_thumb, if: :image? do
    process quality: 90
    process :resize_to_fit => [60, 40]
  end

  def image?(file)
    file.content_type.include? 'image'
  end

  def store_content_type
    if file && model
      model.content_type = file.content_type
    end
  end

  def store_original_dimensions
    if file && file.content_type.include?('image') && model
      model.width, model.height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end

end