module Jekyll
  module LanguagePlugin
    class LanguageData
      attr_reader :site, :language

      def initialize(site, language)
        @site = site
        @language = language
      end

      def get(keys)
        obj = retrieve_obj(keys)
        raise Jekyll::LanguagePlugin::PluginError.new("Invalid language data configuration. #{keys.join('.')} not found.") if language_data.nil?
        obj
      end

      def has?(keys)
        !retrieve_obj(keys).nil?
      end

      def retrieve_obj(keys)
        return nil if @language.to_s.empty?
        keys = resolve_dot_notation([language_data, keys])

        obj = site.send(keys.shift)
        traverse_hash(obj, keys)
      end

      def language_data()
        @language_data ||= site.config['language_data'].to_s || 'data.lang.%%'
        @language_data.gsub("%%", @language)
      end

      def traverse_hash(hash, keys)
        return nil if hash.nil?

        for key in keys
          if !hash.is_a?(Hash)
            return hash
          elsif !hash.key?(key)
            return nil
          end
          hash = hash[key]
        end
        hash
      end

      def resolve_dot_notation(keys)
        return keys.split('.') if keys.is_a?(String)
        return [] if !keys.is_a?(Enumerable)

        keys.flat_map do |key|
          resolve_dot_notation(key)
        end
      end
    end
  end
end
