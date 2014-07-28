class ContentBlock < ActiveRecord::Base

  belongs_to :parent, polymorphic: true
  
  @@block_types = [:text_block, :image_block, :video_block, 
    :slideshow_block, :gist_block, :interview_block]
  
  @@block_types.each do |block_type|
    has_one block_type, dependent: :destroy
    accepts_nested_attributes_for block_type
  end

  def path_name
    self.block_type.underscore
  end
  
  def as_json(options = {})
    options.reverse_merge! only: [:id], include: @@block_types
    super(options)
  end

end
