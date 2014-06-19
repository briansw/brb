class Admin::ImagesController < Admin::ApplicationController
  
  private

    def image_params
      params.require(:image).permit(
        :format,
        :attachment,
        :attachment_cache,
        image: [
          :attachment,
          :attachment_cache
        ]
      )
    end
  
end
