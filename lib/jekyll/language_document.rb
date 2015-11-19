module Jekyll
  class LanguageDocument < Document
    alias_method :url_template_orig, :url_template
    alias_method :url_placeholders_orig, :url_placeholders

    def language
      return nil if data.nil? || data['language'].nil?
      data['language']
    end

    def languages
      return nil if data.nil? || data['languages'].nil?
      data['languages']
    end

    def url_template
      return "/:language" + url_template_orig if !language.nil?
      url_template_orig
    end

    def url_placeholders
      url_placeholders_orig.merge!({
        language: language
      })
    end
  end
end
