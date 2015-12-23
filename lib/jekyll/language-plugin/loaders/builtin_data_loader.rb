# Frozen-string-literal: true
# Encoding: utf-8

require 'rubygems'
require 'yaml'

module Jekyll
  module LanguagePlugin
    module Loaders
      class BuiltinDataLoader < BaseLoader
        attr_reader :data

        def initialize(site)
          super
          @data = Hash.new
        end

        def loaded?(language)
          @data.has_key?(language)
        end

        def load(language)
          return true if loaded?(language)

          file = File.expand_path(File.join(File.dirname(__FILE__), '..', '..', '..', '..', 'data', 'lang', "#{language}.yml"))
          return false unless File.file?(file)

          !!@data.merge!(YAML.load_file(file));
        end

        def get(key, language)
          return nil unless loaded?(language)

          traverse_hash(@data, resolve_dot_notation([language, key]))
        end
      end
    end
  end
end

Jekyll::LanguagePlugin.register_loader(Jekyll::LanguagePlugin::Loaders::BuiltinDataLoader)
