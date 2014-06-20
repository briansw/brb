class Image < ActiveRecord::Base

  belongs_to :parent, polymorphic: true

  begin
    mount_uploader :attachment, ImageUploader
  rescue
    mount_uploader :attachment, Admin::AttachmentUploader
  end

end
