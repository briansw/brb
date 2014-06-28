class Slide < ActiveRecord::Base
  include Concerns::HasImage

  belongs_to :slideshow_block

  before_save :set_video_id,        if: :is_video?
  validates_presence_of :video_url, if: :is_video?
  validate :is_a_youtube_link,      if: :is_video?

  has_image

  def self.types
    %w(image video text)
  end

  def of_type? type
    self.slide_type == type.to_s
  end

  def is_video?
    of_type? :video
  end

  private

  def is_a_youtube_link
    unless self.errors.any? || self.video_url.include?('youtube.com')
      errors.add(:video_url, 'must be from YouTube')
    end
  end

  def set_video_id
    self.video_id = self.video_url.gsub(/.*youtube.com.*=(.*)/, $1.to_s)
  end

end