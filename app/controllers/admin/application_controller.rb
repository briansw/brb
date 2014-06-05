class Admin::ApplicationController < InheritedResources::Base
  layout 'admin'
  before_action :authenticate_user!
  
  include Admin::Concerns::PunditLockdown
  include Admin::Concerns::CRUDMethods
  include Admin::Concerns::Taggings

end
