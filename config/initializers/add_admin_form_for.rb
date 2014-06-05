module ActionView
  module Helpers
    module FormHelper
      
      def admin_form_for(record, options = {}, &proc)
        options[:builder] = Admin::FormBuilder
        content_tag :div, class: "record-form" do
          form_for(record, options, &proc)
        end
      end
      
      def admin_fields_for(record_name, record_object = nil, options = {}, &block)
        options[:builder] = Admin::FormBuilder
        fields_for(record_name, record_object, options, &block)
      end
      
    end
  end
end
