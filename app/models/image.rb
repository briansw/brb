class Image < ActiveRecord::Base

  belongs_to :parent, polymorphic: true

  mount_uploader :attachment, AttachmentUploader

end
