# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Tags
      require_relative 'tags/language'
      require_relative 'tags/language_include'
      require_relative 'tags/language_name'
      require_relative 'tags/language_name_native'
    end
  end
end
