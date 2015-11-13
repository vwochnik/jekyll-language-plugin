module Jekyll
  class LanguagePage < Page
    alias_method :template_orig, :template
    alias_method :url_placeholders_orig, :url_placeholders

    def language
      return nil if data.nil? || data['language'].nil?
      data['language']
    end

    def languages
      return nil if data.nil? || data['languages'].nil?
      data['languages']
    end

    def template
      if language
        return "/:language" + template_orig
      end
      template_orig
    end

    def url_placeholders
      p = url_placeholders_orig
      p['language'] = language
      p
    end
  end
end
