module Jekyll
  module LanguagePlugin
    module DateLocalizer
      def self.localize_date(date, format, context)
        language_data = Jekyll::LanguagePlugin::LiquidContext.get_language_data(context)
        translation = language_data.get('date')

        raise Jekyll::LanguagePlugin::PluginError.new('No localized date available.') if translation.nil?

        # validate language translation
        if !['abbr_daynames', 'daynames', 'abbr_monthnames', 'monthnames'].all? {|s| translation.key?(s) && translation[s].is_a?(Array) } ||
           translation['abbr_daynames'].size < 7 || translation['daynames'].size < 7 ||
           translation['abbr_monthnames'].size < 12 || translation['monthnames'].size < 12
          raise Jekyll::LanguagePlugin::PluginError.new('Invalid localized date translation.')
        end

        date.strftime(
          format.gsub(/%([aAbB])/){ |m|
              case $1
                when 'a'; translation['abbr_daynames'][date.wday]
                when 'A'; translation['daynames'][date.wday]
                when 'b'; translation['abbr_monthnames'][date.mon-1]
                when 'B'; translation['monthnames'][date.mon-1]
                else
                  raise Jekyll::LanguagePlugin::PluginError.new('Internal error.')
              end
            })
      end
    end
  end
end
