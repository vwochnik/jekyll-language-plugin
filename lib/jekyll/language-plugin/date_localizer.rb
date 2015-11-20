module Jekyll
  module LanguagePlugin
    module DateLocalizer
      def self.localize_date(date, format, context)
        translation = LiquidContext.get_language_data(context, 'date')

        # validate language translation
        raise PluginError.new('Localized date is missing translation.') if translation.nil? ||
          !['abbr_daynames', 'daynames', 'abbr_monthnames', 'monthnames'].all? {|s| translation.key?(s) && translation[s].is_a?(Array) } ||
          translation['abbr_daynames'].size < 7 || translation['daynames'].size < 7 ||
          translation['abbr_monthnames'].size < 12 || translation['monthnames'].size < 12

        #convert to extended Time class
        date2 = JLPTime.at(date.to_i)
        date2.strftime_translate(format, translation)
      end

      class JLPTime < Time
        def strftime_translate(format = '%F', translation)
          result = self.strftime(
            #...you replaced the language dependent parts.
            format.gsub(/%([aAbB])/){ |m|
                case $1
                  when 'a'; translation['abbr_daynames'][self.wday]
                  when 'A'; translation['daynames'][self.wday]
                  when 'b'; translation['abbr_monthnames'][self.mon-1]
                  when 'B'; translation['monthnames'][self.mon-1]
                  else
                    raise Jekyll::LanguagePlugin::PluginError.new('Internal error.')
                end
              })
          if defined? @@encoding_converter
            @@encoding_converter.iconv(result)
          else
            result
          end
        end
      end
    end
  end
end
