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

        subset = context.registers[:page]['subset']
        str = language_data.get([subset, key]) unless subset.to_s.empty?
        str ||= language_data.get(key)

        raise Jekyll::LanguagePlugin::PluginError.new('Key #{key} not found intranslation.') if str.nil?
        str
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
