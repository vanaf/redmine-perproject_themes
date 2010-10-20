require 'redmine'

require "#{RAILS_ROOT}/config/initializers/session_store.rb"

#require 'application'
require 'css_patch'

require 'css_hooks'


Redmine::Plugin.register :redmine_css_adder do
  name 'Redmine Css Adder plugin'
  author 'Ivan Afonichev'
  description 'This is a plugin for Redmine'
  version '0.0.1'
end
