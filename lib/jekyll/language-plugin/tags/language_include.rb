# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  module LanguagePlugin
    module Tags
      class LanguageIncludeTag < Jekyll::Tags::IncludeTag
        def tag_includes_dir(context)
          (context.registers[:site].config['language_includes_dir'].to_s || '_i18n').freeze
        end

        def page_language(context)
          if context.registers[:page].nil? || context.registers[:page]['language'].to_s.empty?
            raise Jekyll::LanguagePlugin::PluginError.new('No language specified for current page or post.')
          end
          context.registers[:page].nil? ? "." : context.registers[:page]["language"]
        end

        def resolved_includes_dir(context)
          File.join(context.registers[:site].in_source_dir(@includes_dir), page_language(context))
        end
      end
    end
  end
end

Liquid::Template.register_tag('tinclude', Jekyll::LanguagePlugin::Tags::LanguageIncludeTag)
