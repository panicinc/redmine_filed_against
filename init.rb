require 'redmine'
require_dependency 'query_patch'
require_dependency 'issue_patch'
require_dependency 'project_patch'
require_dependency 'version_patch'
require_dependency 'project_hooks'
require_dependency 'issue_hooks'
require_dependency 'issue_helper_patch'

Redmine::Plugin.register :redmine_filed_against do
  name 'Redmine Filed Against plugin'
  author 'James Moore (Panic Inc.)'
  description 'Adds a filed_against field to issues'
  
  version '1.0.0'
end
