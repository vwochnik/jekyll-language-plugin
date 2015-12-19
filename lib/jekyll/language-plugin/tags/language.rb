# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Tags
      class LanguageTag < Liquid::Tag
        def initialize(tag_name, markup, tokens)
          super
          @markup = markup
        end

        def render(context)
          p = Liquid::Parser.new(@markup)
          name = Liquid::Expression.parse(exp = p.expression)
          key = context.evaluate(name)
          raise Liquid::SyntaxError.new("Invalid language key expression: #{exp}") if key.nil?

          tokens = Array.new
          if p.consume?(:colon)
            loop do
              arg = Liquid::Expression.parse(exp = p.expression)
              token = context.evaluate(arg)
              raise Liquid::SyntaxError.new("Invalid parameter expression: #{exp}") if token.nil?
              tokens.push(token)
              break if !p.consume?(:comma)
            end
          end

           Jekyll::LanguagePlugin::LiquidContext.get_language_string(context, key, tokens)
        end
      end
    end
  end
end

Liquid::Template.register_tag('t', Jekyll::LanguagePlugin::Tags::LanguageTag)
