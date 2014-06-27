class ImageUploader < Admin::AttachmentUploader

  # Brb currently requires MiniMagick for Admin Versions
  include CarrierWave::MiniMagick
  # include CarrierWave::RMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
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

end