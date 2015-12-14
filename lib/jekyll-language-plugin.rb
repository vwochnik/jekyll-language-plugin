module Jekyll

  # internal requires for plugin
  autoload :LanguageReader,     'jekyll/language_reader.rb'
  autoload :LanguageProperties, 'jekyll/language_properties.rb'
  autoload :LanguagePage,       'jekyll/language_page.rb'
  autoload :LanguageDocument,   'jekyll/language_document.rb'
  autoload :LanguagePageReader, 'jekyll/readers/language_page_reader.rb'
  autoload :LanguagePostReader, 'jekyll/readers/language_post_reader.rb'

  module LanguagePlugin

    # plugin requires
    autoload :PluginError,        'jekyll/language-plugin/plugin_error.rb'
    autoload :LanguageData,       'jekyll/language-plugin/language_data.rb'
    autoload :LiquidContext,      'jekyll/language-plugin/liquid_context.rb'
    autoload :DateLocalizer,      'jekyll/language-plugin/date_localizer.rb'
    autoload :VERSION,            'jekyll/language-plugin/version'

    module Loaders
      autoload :BaseLoader,       'jekyll/language-plugin/loaders/base_loader.rb'
    end

    class << self
      def register_loader(loader)
        LanguageData.register_loader(loader)
      end
    end
  end
end

# require data built-in loaders
require 'jekyll/language-plugin/loaders/jekyll_data_loader.rb'
require 'jekyll/language-plugin/loaders/builtin_data_loader.rb'

# require liquid tags and filters
Dir[File.join(File.dirname(__FILE__), 'jekyll/language-plugin/tags/*.rb')].each{ |f| require f }
require 'jekyll/language-plugin/filters/language_date.rb'

Jekyll::Hooks.register :site, :after_reset do |site|
  # replace Jekyll::Reader with Jekyll::LanguageReader extension
  site.reader = Jekyll::LanguageReader.new(site)

  # add dynamic languageData property
  unless site.respond_to?(:languageData) && site.respond_to?(:languageData=)
    site.class.module_eval { attr_accessor :languageData }
  end

  # create new language data instance
  site.languageData = Jekyll::LanguagePlugin::LanguageData.new(site)
end

# monkey patch URL.sanitize_url for handling of triple slashes
module Jekyll
  class URL
    # optimized version by Jordon Bedwell
    def sanitize_url(str)
      "/" + str.gsub(/\/{2,}/, "/").gsub(%r!\.+\/|\A/+!, "")
    end
  end
end
