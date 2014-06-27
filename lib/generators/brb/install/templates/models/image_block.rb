class ImageBlock < ActiveRecord::Base
  include Concerns::HasImage

  belongs_to :content_block

  has_image :image

  def as_json(options = {})
    options.reverse_merge! only: [:title, :caption]
    super(options)
  end

end
