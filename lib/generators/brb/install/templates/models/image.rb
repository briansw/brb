class Image < ActiveRecord::Base
  include Brb::Model::Basic

  belongs_to :parent, polymorphic: true

  mount_uploader :attachment, AttachmentUploader

end