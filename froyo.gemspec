Gem::Specification.new do |s|
  s.name = 'froyo'
  s.version = '0.0.1'
  s.licenses = ['MIT']
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ['Michael "Gilli" Gilliland']
  s.date = '2014-04-07'
  s.summary = 'Fluent Ruby Objects, Yo!'
  s.description = 'Your wildest dreams have come true! Fluent ruby objects!'
  s.files = ['lib/froyo.rb',
             'spec/lib/froyo_spec.rb',
             'LICENSE',
             'README.md']
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-rspec'
  s.add_development_dependency 'rubocop'
end
