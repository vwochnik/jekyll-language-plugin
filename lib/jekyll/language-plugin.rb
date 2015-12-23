# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin

    # plugin requires
    require_relative 'language-plugin/plugin_error'
    require_relative 'language-plugin/language_data'
    require_relative 'language-plugin/liquid_context'
    require_relative 'language-plugin/date_localizer'
    require_relative  'language-plugin/version'

    class << self
      def register_loader(loader)
        LanguageData.register_loader(loader)
      end
    end

    require_relative 'language-plugin/loaders'
    require_relative 'language-plugin/tags'
    require_relative 'language-plugin/filters'
  end
end
