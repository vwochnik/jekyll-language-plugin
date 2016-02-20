# Frozen-string-literal: true
# Encoding: utf-8

require 'jekyll'

require_relative 'jekyll/language_reader.rb'
require_relative 'jekyll/language_properties.rb'
require_relative 'jekyll/language_page.rb'
require_relative 'jekyll/language_document.rb'
require_relative 'jekyll/drops/language_url_drop.rb'
require_relative 'jekyll/readers/language_collection_reader.rb'
require_relative 'jekyll/readers/language_page_reader.rb'
require_relative 'jekyll/readers/language_post_reader.rb'
require_relative 'jekyll/patches'
require_relative 'jekyll/language-plugin'

Jekyll::Hooks.register :site, :after_reset do |site|
  # replace Jekyll::Reader with Jekyll::LanguageReader extension
  site.reader = Jekyll::LanguageReader.new(site)

  # create new language data instance
  site.languageData = Jekyll::LanguagePlugin::LanguageData.new(site)
end
