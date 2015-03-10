module Admin::Concerns::PermitParams
  extend ActiveSupport::Concern

  private

  def standalone_images_params
    {
      image_attributes: [
        image_params
      ]
    }
  end

  def image_params
    [
      :id,
      :attachment,
      :attachment_cache,
      :parent_id,
      :parent_type,
      :caption,
      :position,
      :width,
      :height,
      :content_type,
      :_destroy
    ]
  end

  ########################################
  ###### Content Blocks ##################
  ########################################

  def content_block_params
    {
      content_blocks_attributes: [
        :id,
        :_destroy,
        :parent_type,
        :parent_id,
        :position,
        :block_type,
        text_block_params,
        image_block_params,
        slideshow_block_params,
        video_block_params
      ]
    }
  end

  def text_block_params
    {
      text_block_attributes: [
        :id,
        :title,
        :body
      ]
    }
  end

  def image_block_params
    {
      image_block_attributes: [
        :id,
        :title,
        :caption,
        image_attributes: [
          image_params
        ]
      ]
    }
  end

  def slideshow_block_params
    {
      slideshow_block_attributes: [
        :id,
        slides_attributes: [
          :id,
          :_destroy,
          :slide_type,
          :caption,
          :position,
          :video_url,
          :video_id,
          image_attributes: [
            image_params
          ]
        ]
      ]
    }
  end

  def video_block_params
    {
      video_block_attributes: [
        :id,
        :url,
        :video_id,
        :title,
        :caption
      ]
    }
  end

end
