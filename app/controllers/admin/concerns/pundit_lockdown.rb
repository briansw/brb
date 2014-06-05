module Admin::Concerns::PunditLockdown
  extend ActiveSupport::Concern
  
  included do
    include Pundit
    
    rescue_from Pundit::NotAuthorizedError, with: :deny_access!
  end
  
  protected
  
  def deny_access!
    redirect_to admin_root_url, alert: t("admin.access.denied")
  end
  
end