module Jekyll
  module Tags
    class LanguageTag < Liquid::Tag
      def initialize(tag_name, markup, tokens)
        super
        @params = markup.gsub(/\s+/m, ' ').strip.split(" ")
        @lkey = @params.shift
      end

      def render(context)
        str = JekyllLanguagePlugin::LiquidContext.get_language_string(context, @lkey)
        return "" if str.nil?

        @params.each { |p| str.sub!("%%", p) }
        str
      end
    end
  end
end

Liquid::Template.register_tag('t', Jekyll::Tags::LanguageTag)
