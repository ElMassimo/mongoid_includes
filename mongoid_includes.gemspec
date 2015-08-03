Gem::Specification.new do |s|
  s.name = 'mongoid_includes'
  s.version = '1.0.0'
  s.licenses = ['MIT']
  s.summary = 'Improved eager loading support for Mongoid.'
  s.description = 'Mongoid::Includes improves eager loading in Mongoid, supporting polymorphic associations, and up to two-levels of eager loading.'
  s.authors = ['Máximo Mussini']

  s.email = ['maximomussini@gmail.com']
  s.homepage = %q{https://github.com/ElMassimo/mongoid_includes}

  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>=2.0.0'
  s.rdoc_options = ['--charset=UTF-8']

  s.require_path = 'lib'
  s.files        = Dir.glob('lib/**/*') + %w(CHANGELOG.md LICENSE.txt README.md Rakefile)
  s.test_files   = Dir.glob('spec/**/*')

  s.add_development_dependency 'pry'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec-given'

  s.add_runtime_dependency 'mongoid', ['>= 3.1.0', '< 5.0.0']
end
