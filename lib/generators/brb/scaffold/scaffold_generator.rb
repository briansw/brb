class Brb::ScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  check_class_collision suffix: 'Controller'
  check_class_collision suffix: 'Policy'

  def create_resource
    case self.behavior
    when :invoke
      generate :resource, file_name, *args
      inject_into_file File.join('app', 'models', "#{file_name}.rb"), after: %r{^class.*\n} do
        "  include Brb::Model::Basic\n"
      end
    when :revoke
      destroy :resource, file_name
    end
  end

  def create_admin_controller
    template 'controller.rb', File.join('app', 'controllers', 'admin', "#{file_name.pluralize}_controller.rb")
  end

  def create_form
    template '_form.html.erb', File.join('app', 'views', 'admin', file_name.pluralize, '_form.html.erb')
  end

  def create_policy
    template 'policy.rb', File.join('app', 'policies', "#{file_name}_policy.rb")
  end

  def add_admin_route
    route "admin_for :#{file_name.pluralize}"
  end

  protected

  def permitted_attributes
    args.map {|a| a.split(":").first.to_sym }
  end

  def destroy what, *args
    log :destroy, file_name
    argument = args.flat_map {|arg| arg.to_s }.join(" ")
    in_root do
      run_ruby_script! "bin/rails destroy #{what} #{argument}", verbose: false
    end
  end

  def run! command, config = {}
    # Clone of #run without the requirement of behavior == :invoke

    destination = relative_to_original_destination_root(destination_root, false)
    desc = "#{command} from #{destination.inspect}"

    if config[:with]
      desc = "#{File.basename(config[:with].to_s)} #{desc}"
      command = "#{config[:with]} #{command}"
    end

    say_status :run, desc, config.fetch(:verbose, true)

    unless options[:pretend]
      config[:capture] ? `#{command}` : system("#{command}")
    end
  end

  def run_ruby_script! command, config = {}
    # Clone of #run_ruby_script without the requirement of behavior == :invoke
    run! command, config.merge(:with => Thor::Util.ruby_command)
  end

end
