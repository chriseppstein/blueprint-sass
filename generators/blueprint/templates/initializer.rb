Sass::Plugin.options ||= {}

template_locations = Array(Sass::Plugin.options[:template_location])
css_locations      = Array(Sass::Plugin.options[:css_location])

template_locations << "#{RAILS_ROOT}/app/stylesheets"
template_locations << "#{RAILS_ROOT}/vendor/plugins/blueprint-sass/blueprint"

css_locations << "#{RAILS_ROOT}/public/stylesheets"
css_locations << "#{RAILS_ROOT}/public/stylesheets/blueprint"

Sass::Plugin.options[:template_location] = template_locations
Sass::Plugin.options[:css_location] = css_locations