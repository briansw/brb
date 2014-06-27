class Admin::AttachmentUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :admin_tiny_thumb, if: :image? do
    process :resize_to_fit => [30, 30]
  end

  version :admin_thumb, if: :image? do
    process quality: 90
    process :resize_to_fit => [100, 100]
  end

  version :half_column, if: :image? do
    process quality: 90
    process resize_to_fit: [75, 200]
  end

  def image?(file)
    file.content_type.include? 'image'
  end

end