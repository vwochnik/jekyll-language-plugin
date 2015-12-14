module Jekyll
  module LanguagePlugin
    module Loaders
      class BaseLoader
        attr_reader :site

        def initialize(site)
          @site = site
          @is_loaded = false
        end

        def loaded?(language)
          false
        end

        def load(language)
          true
        end

        def get(key, language)
          nil
        end

        def traverse_hash(hash, keys)
          for key in keys
            return hash unless hash.is_a?(Hash)
            return nil unless hash.key?(key)
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
end
