# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'polisher/version'

PKG_FILES =
  Dir.glob('{lib,spec}/**/*.rb') +
  Dir.glob('spec/data/*') +
  ['LICENSE', 'Rakefile', 'README.md']

Gem::Specification.new do |s|
  # Dynamically create the authors information {name => e-mail}
  authors_hash = Hash[`git log --no-merges --reverse --format='%an,%ae'`.split("\n").uniq.collect {|i| i.split(",")}]

  s.author        = authors_hash.keys
  s.email         = authors_hash.values
  s.summary       = %q{Ruby Project Post-Publishing Processor}
  s.description   = %q{General API and utility scripts to manipulate and query ruby gems and projects after being published}
  s.homepage      = %q{https://github.com/ManageIQ/polisher}
  s.licenses      = ["MIT"]

  s.name          = 'polisher'
  s.version       = Polisher::VERSION
  s.files         = PKG_FILES
  s.executables   = ['binary_gem_resolver.rb', 'gem_dependency_checker.rb',
                     'git_gem_updater.rb', 'ruby_rpm_spec_updater.rb']
  s.require_paths = ['lib']

  s.add_dependency('colored')
  s.add_dependency('activesupport')
  s.add_development_dependency('rspec', '~> 2.0')
  s.add_development_dependency('coveralls')
  s.add_development_dependency('json')
  s.add_development_dependency('curb')
  s.add_development_dependency('i18n')
  s.add_development_dependency('bundler')
  s.add_development_dependency('pkgwat')
  s.add_development_dependency('awesome_spawn')
  s.add_development_dependency('gem2rpm')
  s.add_development_dependency('versionomy')
  s.add_development_dependency('vcr')
  s.add_development_dependency('webmock')

  s.requirements << 'json (RubyGem)'
  s.requirements << 'curb (RubyGem)'
  s.requirements << 'i18n (RubyGem)'
  s.requirements << 'pkgwat (RubyGem)'
  s.requirements << 'awesome_spawn (RubyGem)'
  s.requirements << 'gem2rpm (RubyGem)'
  s.requirements << 'versionomy (RubyGem)'
  s.requirements << 'vcr (RubyGem)'
  s.requirements << 'webmock (RubyGem)'
  s.requirements << 'git'
  s.requirements << 'diff'
  s.requirements << 'fedpkg'
  s.requirements << 'md5sum'
  s.requirements << 'koji'
  s.requirements << 'yum'
  s.requirements << 'rpmdev-packager (from rpmdevtools)'

  s.post_install_message = "=====================================================\n" +
                           "Some of the Polisher components require the following\n" +
                           "RubyGems and programs to be installed:\n\n" +
                           s.requirements.join("\n") + "\n" +
                           "======================================================"
end
