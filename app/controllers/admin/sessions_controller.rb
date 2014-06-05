class Admin::SessionsController < ApplicationController

    layout 'admin'

    def new
    end

    def create
      user = User.where('username = ? or email = ?', params[:username_or_email], params[:username_or_email]).first
      if user && user.authenticate(params[:password])
        if user.active?
          set_user_session(user)
          redirect_to admin_root_path
        else
          redirect_to admin_login_path, alert: 'User not active'
        end
      else
        redirect_to admin_login_path, alert: 'Invalid username/password combination'
      end
    end

    def destroy
      set_user_session
      redirect_to admin_login_path, notice: 'Logged out successfully'
    end

    private
    
      def set_user_session(user = nil)
        session[:user_id]    = user.present? ? user.id         : nil
        session[:username]   = user.present? ? user.username   : nil
        session[:is_admin]   = user.present? ? user.is_admin   : nil
        session[:is_sysop]   = user.present? ? user.is_sysop   : nil
        session[:first_name] = user.present? ? user.first_name : nil
        session[:last_name]  = user.present? ? user.last_name  : nil
      end

end
