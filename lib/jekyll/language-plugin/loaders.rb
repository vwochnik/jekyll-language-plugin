# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Loaders
      require_relative 'loaders/base_loader.rb'
      require_relative 'loaders/jekyll_data_loader.rb'
      require_relative 'loaders/builtin_data_loader.rb'
    end
  end
end
