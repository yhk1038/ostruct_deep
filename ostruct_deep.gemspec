
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ostruct_deep/version'

Gem::Specification.new do |spec|
  spec.name          = 'ostruct_deep'
  spec.version       = OstructDeep::VERSION
  spec.authors       = ['Fred Kim']
  spec.email         = ['yhkks1038@gmail.com']

  spec.summary       = %q{Make deeper ostruct}
  spec.description   = %q{Make more deeper ostruct such as method chain of javascript object}
  spec.homepage      = 'https://github.com/yhk1038/ostruct_deep'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '~> 2.0'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
end
