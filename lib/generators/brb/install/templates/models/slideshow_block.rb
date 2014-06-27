class SlideshowBlock < ActiveRecord::Base

  belongs_to :content_block

  has_many :slides, -> { order(position: :asc, created_at: :asc) }, dependent: :destroy
  accepts_nested_attributes_for :slides, allow_destroy: true

  def as_json(options = {})
    options.reverse_merge! only: [:caption]
    super(options)
  end

end
