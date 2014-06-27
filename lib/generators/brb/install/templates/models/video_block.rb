class VideoBlock < ActiveRecord::Base

  belongs_to :content_block

  validates_presence_of :url
  validate :is_a_youtube_link
  validates_length_of :title, maximum: 255

  before_save :set_video_id

  private

  def is_a_youtube_link
    unless self.url.include?('youtube.com')
      errors.add(:url, 'must be from YouTube')
    end
  end

  def set_video_id
    self.video_id = self.url.gsub(/.*youtube.com.*=(.*)/, $1.to_s)
  end

  def as_json(options = {})
    options.reverse_merge! only: [:title, :caption, :url]
    super(options)
  end

end
