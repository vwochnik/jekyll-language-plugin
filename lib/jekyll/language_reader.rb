# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class LanguageReader < Reader
    def retrieve_posts(dir)
      site.posts.docs.concat(LanguagePostReader.new(site).read_posts(dir))
      site.posts.docs.concat(LanguagePostReader.new(site).read_drafts(dir)) if site.show_drafts
    end

    def retrieve_pages(dir, dot_pages)
      site.pages.concat(LanguagePageReader.new(site, dir).read(dot_pages))
    end
  end
end
