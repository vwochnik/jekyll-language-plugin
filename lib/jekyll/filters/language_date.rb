module Jekyll
  module Filters
    module LanguageDate
      def tdate(input, fkey)
        if ((input.is_a?(String) && !/^\d+$/.match(input).nil?) || input.is_a?(Integer)) && input.to_i > 0
          date = Time.at(input.to_i)
        elsif input.is_a?(String)
          case input.downcase
          when 'now', 'today'
            date = Time.now
          else
            date = Time.parse(input)
          end
        elsif input.is_a?(Time)
          date = input
        else
          date = nil
        end

        return "" if !date.is_a?(Time)
        format = JekyllLanguagePlugin::LiquidContext.get_language_string(@context, fkey)
        return "" if format.nil?

        JekyllLanguagePlugin::DateLocalizer.localize_date(date, format, @context).to_s
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::Filters::LanguageDate)
