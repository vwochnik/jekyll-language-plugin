# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Loaders
      class JekyllDataLoader < BaseLoader
        def initialize(site)
          super
        end

        def get(key, language)
          key = resolve_dot_notation(key)

          data = get_language_data(language)
          traverse_hash(data, key)
        end

        def get_language_data(language)
          @language_data ||= site.config['language_data'].to_s || 'data.lang.%%'
          language_data_l = @language_data.gsub("%%", language)

          key = resolve_dot_notation(language_data_l)

          obj = site.send(key.shift)
          obj = traverse_hash(obj, key)
          raise Jekyll::LanguagePlugin::PluginError.new("Invalid language data configuration. Cannot retrieve data for language #{language} at #{language_data_l}") if obj.nil?
          obj
        end
      end
    end
  end
end

Jekyll::LanguagePlugin.register_loader(Jekyll::LanguagePlugin::Loaders::JekyllDataLoader)
