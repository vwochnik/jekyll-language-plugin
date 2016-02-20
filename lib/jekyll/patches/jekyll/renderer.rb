# Frozen-string-literal: true
# Encoding: utf-8

module Jekyll
  class Renderer
    def permalink_ext
      if document.permalink && !document.permalink.end_with?("/")
        ext_match = document.permalink.match(/\.[\w+-]+$/)
        ext_match[0] unless ext_match.nil?
      end
    end
  end
end
