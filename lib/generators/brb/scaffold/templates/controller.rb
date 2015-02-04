class Admin::<%= class_name.pluralize %>Controller < Admin::ApplicationController
  include Admin::Concerns::PermitParams

  private

  def <%= class_name.underscore %>_params
    params.require(<%= class_name.underscore.to_sym.inspect %>)
    <%- if permitted_attributes.any? -%>
          .permit(<%= permitted_attributes %>)
    <%- else -%>
          .permit!
    <%- end -%>
  end
end
