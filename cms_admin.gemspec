$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'cms_admin/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'cms_admin'
  s.version     = CmsAdmin::VERSION
  s.authors     = ['Thomas Ochman']
  s.email       = ['thomas@agileventures.org']
  s.homepage    = ''
  s.summary     = 'Summary of CmsAdmin.'
  s.description = 'Description of CmsAdmin.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  s.require_paths = ['lib']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.2.0'
  s.add_dependency 'devise'

  s.add_runtime_dependency 'pg'

  s.add_development_dependency 'pry-rails'
end
