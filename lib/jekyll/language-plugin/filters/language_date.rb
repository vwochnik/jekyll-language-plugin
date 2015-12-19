# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Filters
      module LanguageDateFilter
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
          LiquidContext.get_localized_date(@context, date, fkey)
        end
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::LanguagePlugin::Filters::LanguageDateFilter)
