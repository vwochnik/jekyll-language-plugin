# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Tags
      require_relative 'tags/language'
      require_relative 'tags/language_include'
      require_relative 'tags/language_name'
    end
  end
end
