class TextBlock < ActiveRecord::Base

  belongs_to :content_block

  validates_presence_of :body
  validates_length_of :title, maximum: 255

  def as_json(options = {})
    options.reverse_merge! only: [:title, :body]
    super(options)
  end

end
