# Delete unnecessary files
run 'rm README'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/robots.txt'

run 'cp config/database.yml config/database.yml.example'

file '.gitignore', <<-END
log
tmp
config/database.yml
db/*.sqlite3
END

git :init
git :add => '.'
git :commit => "-a -m 'Initial commit'"

## auth
gem 'warden'
gem 'devise'

generate :devise_install

# rake("gems:unpack") ?

git :add => '.'
git :commit => "-a -m 'auth is on'"

## rspec
generate 'rspec'

file 'spec/my_spec_helper.rb', <<-MY_SPEC_HELPER
require File.expand_path(File.dirname(__FILE__) + '/blueprints')
require 'email_spec'

Spec::Runner.configure do |config|
  config.before(:all)    { Sham.reset(:before_all)  }
  config.before(:each)   { Sham.reset(:before_each) }

  config.include(EmailSpec::Helpers)
  config.include(EmailSpec::Matchers)
end
MY_SPEC_HELPER

#TODO move this before the line Spec::Runner.configure do |config|
req_my_spec_helper = <<-REQ_MY_SPEC_HELPER

require 'my_spec_helper'

REQ_MY_SPEC_HELPER

File.open('spec/spec_helper.rb', 'a') do |spec_helper|
  spec_helper.write req_my_spec_helper
end

file 'spec/blueprints.rb', <<-BLUEPRINTS
require 'machinist/active_record'
require File.expand_path(File.dirname(__FILE__) + '/shams')
# dump your blueprints here
BLUEPRINTS

file 'spec/shams.rb', <<-SHAMS
require 'sham'
require 'faker'
# dump your shams here
SHAMS

git :add => '.'
git :commit => "-a -m 'RSpec is on'"

## cucumber
generate 'cucumber'
generate 'email_spec'

file 'features/support/my_env.rb', <<-MY_ENV
  require File.expand_path(File.dirname(__FILE__) + '../../../spec/blueprints')

  require 'email_spec/cucumber'
MY_ENV

git :add => '.'
git :commit => "-a -m 'Cucumber is on'"
