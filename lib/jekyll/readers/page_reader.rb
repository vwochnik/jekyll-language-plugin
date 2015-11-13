module Jekyll
  class PageReader
    def read(files)
      for file in files do
        page = LanguagePage.new(@site, @site.source, @dir, file)
        if page.languages
          for language in page.languages do
            if page.language == language
              @unfiltered_content << page
            elsif page.language.nil?
              page.data['language'] = language
              @unfiltered_content << page
            else
              page2 = LanguagePage.new(@site, @site.source, @dir, file)
              page2.data['language'] = language
              @unfiltered_content << page2
            end
          end
        else
          @unfiltered_content << page
        end
      end
      @unfiltered_content.select{ |page| site.publisher.publish?(page) }
    end
  end
end
