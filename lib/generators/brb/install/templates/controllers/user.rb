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
        :active
      )
    end
end
