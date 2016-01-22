# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class LanguageCollectionReader < CollectionReader
    def read
      site.collections.each do |_, collection|
        next if SPECIAL_COLLECTIONS.include?(collection.label)
        collection.read
        collection.docs = collection.docs.flat_map do |document|
          ldocuments = []
          ldocument = LanguageDocument.new(document.path, { site: @site, collection: collection })
          ldocument.read

          if ldocument.languages
            for language in ldocument.languages do
              if ldocument.language == language
                ldocuments << ldocument
              elsif ldocument.language.nil?
                ldocument.data['language'] = language
                ldocuments << ldocument
              else
                ldocument2 = LanguageDocument.new(document.path, { site: @site, collection: collection })
                ldocument2.read
                ldocument2.data['language'] = language
                ldocuments << ldocument2
              end
            end
          elsif ldocument.language
            ldocuments << ldocument
          else
            # no languages -> do not add extended Page
            ldocuments << document
          end
          ldocuments
        end
      end
    end
  end
end
