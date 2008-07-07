class BlueprintGenerator < Rails::Generator::NamedBase
  
  def initialize(runtime_args, runtime_options = {})
    runtime_args << "application" if runtime_args.size == 0
    super
  end
  
  def meta_method
    "has_#{file_name}"
  end

  def manifest
    record do |m|
      m.directory 'app/stylesheets'
      m.directory 'lib'
      m.directory 'config/initializers'
      
      m.template 'ie.sass',        File.join('app/stylesheets',     "#{file_name}-ie.sass")
      m.template 'print.sass',     File.join('app/stylesheets',     "#{file_name}-print.sass")
      m.template 'screen.sass',    File.join('app/stylesheets',     "#{file_name}.sass")
      m.template 'initializer.rb', File.join('config/initializers', "blueprint.rb")
      
    end
  end
end