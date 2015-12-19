# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    class DateLocalizer
      attr_reader :translation

      def initialize(translation)
        @translation = translation
      end

      def localize_date(date, format)
        # validate language translation
        if !['abbr_daynames', 'daynames', 'abbr_monthnames', 'monthnames'].all? {|s| translation.key?(s) && translation[s].is_a?(Array) } ||
           translation['abbr_daynames'].size < 7 || translation['daynames'].size < 7 ||
           translation['abbr_monthnames'].size < 12 || translation['monthnames'].size < 12
          raise Jekyll::LanguagePlugin::PluginError.new('Invalid date translation.')
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
