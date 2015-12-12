require 'rubygems'
require 'yaml'

module Jekyll
  module LanguagePlugin
    module Loaders
      class RailsI18nLoader < BaseLoader
        @@data = nil

        def load
          if !@is_loaded
            self.class.load_data if @@data.nil?
            @is_loaded = true
          end
        end

        def get(key, language)
          return nil unless loaded?
          traverse_hash(@@data, [language, key])
        end

        def self.load_data
          gem_root = Gem.loaded_specs['rails-i18n'].full_gem_path
          files = Dir[File.join(gem_root, 'rails', '**', '*.yml')]
          @@data = files.inject(Hash.new) do |data, file|
            key = File.basename(file, '.yml')
            source = YAML.load_file(file)
            break data if !source.has_key?(key) || source[key]['date'].nil?

            # extract date object
            date = source[key]['date']
            date.delete_if { |k, _| k !~ /\A(?:abbr_day_names|abbr_month_names|day_names|month_names)\z/ }
            date = Hash[date.map { |k, v| [k.sub(/_names\Z/, 'names'), v] }]
            date['abbr_monthnames'].shift
            date['monthnames'].shift

            data.merge!({
              key => { 'date' => date }
            })
          end
        end
      end
    end
  end
end

begin
  require 'rails-i18n'
  Jekyll::LanguagePlugin.register_loader(Jekyll::LanguagePlugin::Loaders::RailsI18nLoader)
rescue LoadError
end
