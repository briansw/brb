module Admin::Concerns::CRUDMethods
  extend ActiveSupport::Concern
  
  included do
    respond_to :html, :json
    respond_to :js, only: :index
    
    around_action :set_to_param
  end
  
  def index
    authorize resource_class
    index!
  end
  
  def show
    redirect_to action: :edit
  end
  
  def update
    update! { polymorphic_path([:admin, resource_class]) }
  end

  def create
    create! { polymorphic_path([:admin, resource_class]) }
  end

  protected

  # Overrides inherited_resources collection to insert Pundit scopes
  def collection
    get_collection_ivar || begin
      scope = Pundit.policy_scope!(current_user, resource_class)
        .filter_table(params[:sort], params[:direction], params[:page], params[:assoc_column])
      scope = scope.search(params[:query]) if scope.respond_to? :search
      set_collection_ivar scope
    end
  end

  # Inject authorization into inherited_resources method
  def resource
    object = super
    authorize object
    object
  end

  # Inject authorization into inherited_resources method
  def build_resource
    object = super
    authorize object
    object
  end

  # Overrides inherited_resources update_resource to insert Pundit authorization
  def update_resource(object, attributes)
    object.assign_attributes(*attributes)
    authorize object
    object.save
  end
  
  # Around action which overrides the default to_params method for the action
  def set_to_param
    resource_class.class_eval do
      alias :__admin_to_param :to_param
      def to_param() id.to_s end
    end

    begin
      yield
    ensure
      resource_class.class_eval do
        alias :to_param :__admin_to_param
      end
    end
  end
  
end
