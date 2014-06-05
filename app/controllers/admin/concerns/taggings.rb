module Admin::Concerns::Taggings
  extend ActiveSupport::Concern
  
  def tags
    scope = params[:scope].try(:to_sym) || :tags
    
    @tags = resource_class
      .tag_counts_on(scope)
      .order(:name)
      
    if params[:query].present?
      @tags = @tags.where('name like ?', "%#{params[:query]}%")
    end
    
    respond_with @tags
  end
  
end