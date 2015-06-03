class Image < ActiveRecord::Base
  include Brb::Model::Basic

  default_scope { order(:position) }

  belongs_to :parent, polymorphic: true

  begin
    mount_uploader :attachment, ImageUploader
  rescue
    mount_uploader :attachment, Admin::AttachmentUploader
  end

  def orientation
    width / height > 0 ? :horizontal : :vertical
  end

end
