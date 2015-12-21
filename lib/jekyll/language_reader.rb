# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class LanguageReader < Reader
    def read
      @site.layouts = LayoutReader.new(site).read
      read_directories
      sort_files!
      @site.data = DataReader.new(site).read(site.config['data_dir'])
      LanguageCollectionReader.new(site).read
    end

    def retrieve_posts(dir)
      site.posts.docs.concat(LanguagePostReader.new(site).read_posts(dir))
      site.posts.docs.concat(LanguagePostReader.new(site).read_drafts(dir)) if site.show_drafts
    end

    def retrieve_pages(dir, dot_pages)
      site.pages.concat(LanguagePageReader.new(site, dir).read(dot_pages))
    end
  end
end
