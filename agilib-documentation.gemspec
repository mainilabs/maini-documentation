# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'maini/documentation/version'

Gem::Specification.new do |spec|
  spec.name          = "maini-documentation"
  spec.version       = Maini::Documentation::VERSION
  spec.authors       = ["Marcos Junior"]
  spec.email         = ["marcos@maini.com.br"]

  spec.summary       = "Maini Documentation"
  spec.description   = "Esta gem auxilia na criação da documentação da API do projeto"
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "http://rubygems.agivis.com.br"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-nc"
  spec.add_development_dependency "rack-test"

  spec.add_dependency "rails", Maini::Documentation::RAILS_VERSION
  spec.add_dependency "htmlentities"
  spec.add_dependency "bootstrap-sass"

  spec.add_dependency "rails", ">= 4.2.0"
  spec.add_dependency 'redcarpet', '>= 3.1.0'
  spec.add_dependency 'pygments.rb', '>= 0.5'

  # spec.add_dependency 'sqlite3', '~> 1.3'

end
