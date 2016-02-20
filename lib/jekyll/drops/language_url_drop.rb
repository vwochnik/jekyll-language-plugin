module Jekyll
  module Drops
    class LanguageUrlDrop < UrlDrop
      def language
        @obj.language
      end

      def subset
        @obj.subset
      end
    end
  end
end
