module Jekyll
  module LanguagePlugin
    class LanguageData
      attr_reader :language

      def initialize(site)
        @loaders = self.class.loaders.map{ |l| l.new(site) }
      end

      def get(key, language)
        @loaders.inject(nil) do |result, loader|
          loader.load(language) unless loader.loaded?(language)
          result = loader.get(key, language)
          break result unless result.nil?
        end
      end

      class << self
        def loaders
          @loaders ||= []
        end

        def register_loader(loader)
          loaders.push(loader)
        end
      end
    end
  end
end
