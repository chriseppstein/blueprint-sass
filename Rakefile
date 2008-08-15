require 'rubygems'
require 'rake'

# ----- Default: Testing ------

task :default => :test

require 'rake/testtask'
require 'fileutils'

Rake::TestTask.new do |t|
  t.libs << 'lib'
  test_files = FileList['test/**/*_test.rb']
  test_files.exclude('test/rails/*', 'test/haml/*')
  t.test_files = test_files
  t.verbose = true
end
Rake::Task[:test].send(:add_comment, <<END)
To run with an alternate version of Rails, make test/rails a symlink to that version.
To run with an alternate version of Haml & Sass, make test/haml a symlink to that version.
END

desc "Compile Examples into HTML and CSS"
task :examples do
  linked_haml = "test/haml"
  if File.exists?(linked_haml) && !$:.include?(linked_haml + '/lib')
    puts "[ using linked Haml ]"
    $:.unshift linked_haml + '/lib'
  end
  require 'haml'
  require 'sass'
  require 'pathname'
  FileList['examples/*'].each do |example|
    puts "Compiling #{example} -> compiled_examples/#{example.sub(%r{.*/},'')}"
    FileList["#{example}/*.haml"].each do |haml_file|
      basename = haml_file[9..-6]
      engine = Haml::Engine.new(open(haml_file).read, :filename => haml_file)
      target_dir = "compiled_examples/#{basename.sub(%r{/[^/]*$},'')}"
      FileUtils.mkdir_p(target_dir)
      output = open("compiled_examples/#{basename}",'w')
      output.write(engine.render)
      output.close
    end
    FileList["#{example}/stylesheets/**/[^_]*.sass"].each do |sass_file|
      basename = sass_file[9..-6]
      css_filename = "compiled_examples/#{basename}.css"
      blueprint_sass = File.dirname(__FILE__).sub(%r{.*/},'')
      engine = Sass::Engine.new(open(sass_file).read,
                                  :filename => sass_file,
                                  :line_comments => true,
                                  :css_filename => css_filename,
                                  :load_paths => ["#{example}/stylesheets", "#{File.dirname(__FILE__)}/blueprint"])
      target_dir = "compiled_examples/#{basename.sub(%r{/[^/]*$},'')}"
      FileUtils.mkdir_p(target_dir)
      output = open(css_filename,'w')
      output.write(engine.render)
      output.close      
    end
    # copy any other non-haml and non-sass files directly over
    target_dir = "compiled_examples/#{example.sub(%r{.*/},'')}"
    other_files = FileList["#{example}/**/*"]
    other_files.exclude "**/*.sass", "*.haml"
    other_files.each do |file|
      
      if File.directory?(file)
        FileUtils.mkdir_p(file)
      elsif File.file?(file)
        target_file = "#{target_dir}/#{file[(example.size+1)..-1]}"
        # puts "mkdir -p #{File.dirname(target_file)}"
        FileUtils.mkdir_p(File.dirname(target_file))
        # puts "cp #{file} #{target_file}"
        FileUtils.cp(file, target_file)
      end
    end
  end
end