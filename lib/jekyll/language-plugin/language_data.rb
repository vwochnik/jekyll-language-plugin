# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    class LanguageData
      attr_reader :site, :language

      def initialize(site)
        @site = site
        @l_inst_ary = Array.new
      end

      def get(key, language)
        inject_loader(language) do |loader|
          loader.get(key, language)
        end
      end

      def get_with_placeholders(key, tokens, language)
        inject_loader(language) do |loader|
          loader.get_with_placeholders(key, tokens, language)
        end
      end

      def inject_loader(language)
        self.class.loaders.inject(nil) do |result, loader|
          unless l_inst = @l_inst_ary.detect { |l| l.is_a?(loader) }
            l_inst = loader.new(@site)
            @l_inst_ary.push(l_inst)
          end

          l_inst.load(language) unless l_inst.loaded?(language)
          result = yield l_inst
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
