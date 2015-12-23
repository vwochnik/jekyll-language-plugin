# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Tags
      class LanguageNameTag < Liquid::Tag
        def initialize(tag_name, markup, tokens)
          super
          @markup = markup
        end

        def render(context)
          p = Liquid::Parser.new(@markup)
          name = Liquid::Expression.parse(exp = p.expression)
          key = context.evaluate(name)
          raise Liquid::SyntaxError.new("Invalid language key expression: #{exp}") if key.nil?

          # get language name string from evaluated key
          Jekyll::LanguagePlugin::LiquidContext.get_language_string(context, "lang.#{key}")
        end
      end
    end
  end
end

Liquid::Template.register_tag('tl', Jekyll::LanguagePlugin::Tags::LanguageNameTag)
