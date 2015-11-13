module Jekyll
  class PostReader
    def read_content(dir, magic_dir, matcher)
      entries = @site.reader.get_entries(dir, magic_dir)
      documents = []
      for entry in entries
        next unless entry =~ matcher
        path = @site.in_source_dir(File.join(dir, magic_dir, entry))
        documents.concat(multilinguify(path))
      end
      documents
    end

    def multilinguify(path)
      document = create_document_from_path(path)
      document.read
      if not document.language and not document.languages
        # create a new document that can be freshly read
        return [create_document_from_path(path)]
      end

      languages = document.languages || []
      if document.language and not languages.include?(document.language)
        languages.push(document.language)
      end

      languages.map do |language|
        document2 = create_document_from_path(path)
        document2.data['language'] = language
        document2
      end
    end

    def create_document_from_path(path)
      LanguageDocument.new(path, {
        site: @site,
        collection: @site.posts
      })
    end
  end
end
