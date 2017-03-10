lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cwlog_tail/version'

Gem::Specification.new do |spec|
  spec.name          = 'cwlog_tail'
  spec.version       = CwlogTail::VERSION
  spec.authors       = ['Tomoki Yamashita']
  spec.email         = ['tomorrowkey@gmail.com']

  spec.summary       = %q{Tail CloudWatch log}
  spec.description   = spec.summary
  spec.homepage      = 'http://github.com/tomorrowkey/cwlog_tail'
  spec.license       = 'Apache License 2.0'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'aws-sdk', '~> 2.8'
  spec.add_dependency 'peco_selector', '~> 1.0'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
