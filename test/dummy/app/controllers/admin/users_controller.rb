class Admin::UsersController < Admin::ApplicationController
  
  private

    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email,
        :username,
        :is_admin,
        :is_sysop,
        :password,
        :password_confirmation,
        :active,
        image_attributes
      )
    end
    
    def image_attributes
      [{
        portrait_attributes: [
          :id,
          :attachment,
          :attachment_cache,
          :_destroy
        ]
      },
      {
        baseball_cards_attributes: [
          :id,
          :attachment,
          :attachment_cache,
          :_destroy
        ]
      }]
    end
end
