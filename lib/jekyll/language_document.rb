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
      if language
        return "/:language" + url_template_orig
      end
      url_template_orig
    end

    def url_placeholders
      p = url_placeholders_orig
      p['language'] = language
      p
    end
  end
end
