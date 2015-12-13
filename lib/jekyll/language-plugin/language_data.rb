module Jekyll
  module LanguagePlugin
    class LanguageData
      attr_reader :language

      def initialize(site, language)
        @language = language
        @loaders = Jekyll::LanguagePlugin.loaders.map{ |l| l.new(site) }
      end

      def get(key)
        @loaders.inject(nil) do |result, loader|
          loader.load(@language) unless loader.loaded?(@language)
          result = loader.get(key, @language)
          break result unless result.nil?
        end
      end

      def has?(key)
        !get(key).nil?
      end
    end
  end
end
