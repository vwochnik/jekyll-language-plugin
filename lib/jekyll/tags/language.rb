module Jekyll
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

        # get language string from evaluated key
        str = JekyllLanguagePlugin::LiquidContext.get_language_string(context, key)

        if p.consume?(:colon)
          loop do
            arg = Liquid::Expression.parse(exp = p.expression)
            argstr = context.evaluate(arg)
            raise Liquid::SyntaxError.new("Invalid parameter expression: #{exp}") if argstr.nil?
            raise JekyllLanguagePlugin::PluginError.new("Language string is lacking parameter placeholder.") unless str.include?("%%")
            str.sub!("%%", argstr)
            break if !p.consume?(:comma)
          end
        end
        str
      end
    end
  end
end

Liquid::Template.register_tag('t', Jekyll::Tags::LanguageTag)
