module Jekyll
  module LanguagePlugin
    module LiquidContext
      def self.get_language_data(context)
        context.registers[:site].languageData
      end

      def self.get_language(context)
        language = context.registers[:page]['language']
        if language.to_s.empty?
          raise Jekyll::LanguagePlugin::PluginError.new('No language specified for current page or post.')
        end
        language
      end

      def self.get_language_string(context, key)
        language_data = self.get_language_data(context)
        language = self.get_language(context)

        subset = context.registers[:page]['subset']
        str = language_data.get([subset, key], language) unless subset.to_s.empty?
        str ||= language_data.get(key, language)

        raise Jekyll::LanguagePlugin::PluginError.new("Key #{key} not found in translation.") if str.nil?
        str
      end

      def self.get_localized_date(context, date, format_key)
        language_data = self.get_language_data(context)
        language = self.get_language(context)

        subset = context.registers[:page]['subset']
        format_str = language_data.get([subset, format_key], language) unless subset.to_s.empty?
        format_str ||= language_data.get(format_key, language)

        raise Jekyll::LanguagePlugin::PluginError.new("Date format key #{key} not found in translation.") if format_str.nil?

        date_translation = language_data.get('date', language)
        raise Jekyll::LanguagePlugin::PluginError.new('No localized date available for translation.') if date_translation.nil?

        date_localizer = DateLocalizer.new(date_translation)
        date_localizer.localize_date(date, format_str)
      end

      def self.get_language_name(context, name)
        language_data = self.get_language_data(context)

        language = context.registers[:page]['language']
        if language.to_s.empty?
          raise Jekyll::LanguagePlugin::PluginError.new('No language specified for current page or post.')
        end

        str = language_data.get(['lang', name])

        raise Jekyll::LanguagePlugin::PluginError.new("Language name #{name} not found in translation.") if str.nil?
        str
      end
    end
  end
end
