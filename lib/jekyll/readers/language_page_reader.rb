module Jekyll
  class LanguagePageReader < PageReader
    alias_method :read_orig, :read

    def read(files)
      read_orig(files).flat_map do |page|
        lpages = []
        lpage = LanguagePage.new(@site, @site.source, page.dir, page.name)
        if lpage.languages
          for language in lpage.languages do
            if lpage.language == language
              lpages << lpage
            elsif lpage.language.nil?
              lpage.data['language'] = language
              lpages << lpage
            else
              lpage2 = LanguagePage.new(@site, @site.source, page.dir, page.name)
              lpage2.data['language'] = language
              lpages << lpage2
            end
          end
        elsif lpage.language
          lpages << lpage
        else
          # no languages -> do not add extended Page
          lpages << page
        end
        lpages
      end
    end
  end
end
