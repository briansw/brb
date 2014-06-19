class AttachmentUploader < CarrierWave::Uploader::Base
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

  version :c1, if: :image? do
    process quality: 90
    process resize_to_fit: [140, 400]
  end

  version :c2, if: :image? do
    process quality: 90
    process resize_to_fit: [280, 800]
  end

  version :c4, if: :image? do
    process quality: 90
    process resize_to_fit: [560, 1600]
  end

  version :c8, if: :image? do
    process quality: 90
    process resize_to_fit: [1120, 3200]
  end

  version :full_screen, if: :image? do
    process quality: 90
    process resize_to_fit: [1200, 3430]
  end


  def image?(file)
    file.content_type.include? 'image'
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end