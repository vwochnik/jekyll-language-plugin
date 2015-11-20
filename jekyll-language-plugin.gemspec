# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jekyll/language-plugin/version'

Gem::Specification.new do |spec|
  spec.name          = "jekyll-language-plugin"
  spec.version       = Jekyll::LanguagePlugin::VERSION
  spec.authors       = ["Vincent Wochnik"]
  spec.email         = ["v.wochnik@gmail.com"]
  spec.description   = %q{Jekyll 3.0-compatible multi-language plugin for posts, pages and includes}
  spec.summary       = %q{This plugin enables Jekyll to run multilingual websites where pages and posts can automatically be translated into different languages.}
  spec.homepage      = "https://github.com/vwochnik/jekyll-language-plugin"
  spec.license       = "MIT"

  spec.files         = ["lib/jekyll-language-plugin.rb", *Dir["lib/**/*.rb"], "README.md", "LICENSE.md"]
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'jekyll', '~> 3.0'
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "bundler", "~> 1.6"
end
