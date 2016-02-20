# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class LanguageDocument < Document
    include LanguageProperties

    alias_method :url_template_orig, :url_template
    alias_method :url_placeholders_orig, :url_placeholders

    def url_template
      return "/:language" + url_template_orig if !language.nil?
      url_template_orig
    end

    def url_placeholders
      @url_placeholders ||= Drops::LanguageUrlDrop.new(self)
    end
  end
end
