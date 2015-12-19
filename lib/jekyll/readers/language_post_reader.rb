# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class LanguagePostReader < PostReader
    alias_method :read_content_orig, :read_content

    def read_content(dir, magic_dir, matcher)
      read_content_orig(dir, magic_dir, matcher).flat_map do |document|
        ldocument = LanguageDocument.new(document.path, { site: @site, collection: @site.posts })
        ldocument.read

        languages = ldocument.languages.is_a?(Enumerable) ? ldocument.languages : []
        languages.push(ldocument.language) if ldocument.language && !languages.include?(ldocument.language)
        return [document] if languages.size == 0

        languages.map do |language|
          ldocument2 = LanguageDocument.new(document.path, { site: @site, collection: @site.posts })
          ldocument2.data['language'] = language
          ldocument2
        end
      end
    end
  end
end
