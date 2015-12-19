# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguageProperties
    def language
      return nil if data.nil? || data['language'].nil?
      data['language']
    end

    def languages
      return nil if data.nil? || data['languages'].nil?
      data['languages']
    end

    def subset
      return nil if data.nil? || data['subset'].nil?
      data['subset']
    end
  end
end
