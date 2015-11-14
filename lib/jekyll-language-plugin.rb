# require all files in jekyll subdirectory
require 'jekyll/language_reader.rb'
require 'jekyll/language_page.rb'
require 'jekyll/language_document.rb'
require 'jekyll/readers/language_page_reader.rb'
require 'jekyll/readers/language_post_reader.rb'
require 'jekyll/tags/language.rb'
require 'jekyll/tags/language_include.rb'

# replace Jekyll::Reader upon page reset with Jekyll::LanguageReader extension
Jekyll::Hooks.register :site, :after_reset do |site|
  site.reader = Jekyll::LanguageReader.new(site)
end
