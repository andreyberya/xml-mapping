# -*- encoding: utf-8 -*-
require File.expand_path('../lib/xml/mapping/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Olaf Klischat']
  gem.email         = ['olaf.klischat@sofd.de']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = "An easy to use, extensible library for mapping Ruby objects to XML and back. Includes an XPath interpreter."
  gem.homepage      = "http://xml-mapping.rubyforge.org"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "xml-mapping"
  gem.require_paths = ["lib"]
  gem.version       = XML::Mapping::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.has_rdoc      = true
end
