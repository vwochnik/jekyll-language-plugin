# require all files in jekyll-language-plugin subdirectory
require 'jekyll-language-plugin/plugin_exception.rb'
require 'jekyll-language-plugin/liquid_context.rb'
require 'jekyll-language-plugin/date_localizer.rb'

# require all files in jekyll subdirectory
require 'jekyll/language_reader.rb'
require 'jekyll/language_page.rb'
require 'jekyll/language_document.rb'
require 'jekyll/readers/language_page_reader.rb'
require 'jekyll/readers/language_post_reader.rb'
require 'jekyll/filters/language_date.rb'
require 'jekyll/tags/language.rb'
require 'jekyll/tags/language_name.rb'
require 'jekyll/tags/language_include.rb'

# replace Jekyll::Reader upon page reset with Jekyll::LanguageReader extension
Jekyll::Hooks.register :site, :after_reset do |site|
  site.reader = Jekyll::LanguageReader.new(site)
end

# monkey patch URL.sanitize_url for handling of triple slashes
module Jekyll
  class URL
    def sanitize_url(in_url)
      url = in_url \
        # Remove empty URL segments and every URL segment that consists solely of dots
        .split('/').reject{ |s| s.empty? || s =~ /^\.+$/ }.join('/') \
        # Always add a leading slash
        .gsub(/\A([^\/])/, '/\1')

      # Append a trailing slash to the URL if the unsanitized URL had one
      url << "/" if in_url.end_with?("/")
      
      url
    end
  end
end
