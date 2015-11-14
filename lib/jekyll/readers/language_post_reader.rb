module Jekyll
  class LanguagePostReader < PostReader
    alias_method :read_content_orig, :read_content

    def read_content(dir, magic_dir, matcher)
      read_content_orig(dir, magic_dir, matcher).flat_map do |document|
        ldocument = LanguageDocument.new(document.path, { site: @site, collection: @site.posts })
        ldocument.read

        languages = ldocument.languages.is_a?(Enumerable) ? ldocument.languages : []
        if ldocument.language and not languages.include?(ldocument.language)
          languages.push(ldocument.language)
        end

        if languages.size == 0
          return [document]
        end

        languages.map do |language|
          ldocument2 = LanguageDocument.new(document.path, { site: @site, collection: @site.posts })
          ldocument2.data['language'] = language
          ldocument2
        end
      end
    end
  end
end
