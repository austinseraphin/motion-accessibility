# -*- encoding: utf-8 -*-
VERSION = "3.2.4"

Gem::Specification.new do |spec|
  spec.name          = "motion-accessibility"
  spec.version       = VERSION
  spec.authors       = ["Austin Seraphin"]
  spec.email         = ["austin@austinseraphin.com"]
  spec.description   = %q{AA RubyMotion wrapper around the UIAccessibility procotols}
  spec.summary       = %q{This gem provides easy ruby-like wrappers around the protocols which interact with VoiceOver and other assistive technologies. It also features automated testing for iOS, and a console. Making accessibility accessible! }
  spec.homepage      = "https://github.com/austinseraphin/motion-accessibility"
  spec.license       = "MIT"

  files = []
  files << 'README.md'
  files<<'LICENSE'
  files.concat(Dir.glob('lib/**/*.rb'))
  spec.files         = files
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 10.0"
end
