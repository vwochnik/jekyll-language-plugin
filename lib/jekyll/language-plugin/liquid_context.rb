module Jekyll
  module LanguagePlugin
    module LiquidContext
      def self.get_language_data(context)
        if !context.registers[:language_data].nil?
          return context.registers[:language_data]
        end

        language = context.registers[:page]['language']
        if language.to_s.empty?
          raise Jekyll::LanguagePlugin::PluginError.new('No language specified for current page or post.')
        end

        site = context.registers[:site]
        context.registers[:language_data] = LanguageData.new(site, language)
      end

      def self.get_language_string(context, key)
        language_data = self.get_language_data(context)

        if language_data.nil?
          $stdout.puts("language data is nil")
        end
        subset = context.registers[:page]['subset']
        if !subset.to_s.empty? && language_data.has?([subset, key])
          return language_data.get([subset, key])
        end

        language_data.get(key)
      end

      def self.get_language_name(context, name)
        language_data = self.get_language_data(context)
        translation = language_data.get('lang')

        raise Jekyll::LanguagePlugin::PluginError.new('Language name not found in translation.') if translation.nil? ||
          !translation.key?(name)

        translation[name]
      end
    end
  end
end
